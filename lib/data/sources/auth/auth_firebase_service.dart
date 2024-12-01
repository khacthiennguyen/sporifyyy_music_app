import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sporifyyy/core/configs/constants/app_urls.dart';
import 'package:sporifyyy/data/models/auth/create_user_req.dart';
import 'package:sporifyyy/data/models/auth/signin_user_req.dart';
import 'package:sporifyyy/data/models/auth/user.dart';
import 'package:sporifyyy/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();

  Future<Either> tunOnOrTurnOffBiometrics();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);

      return const Right('Signin wass Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'User not found';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user!.uid).set({
        'userId': data.user!.uid,
        'name': createUserReq.fullname,
        'email': data.user?.email,
        'isBiometrics': false,
      });

      return const Right('Signup wass Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromeJson(user.data()!);
      userModel.imageUrl =
          firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultImage;
      userModel.isBiometrics = user.data()!['isBiometrics'];
      UserEntity userEntity = userModel.toEntity();
      print(userEntity.isBiometric);
      return Right(userEntity);
    } catch (e) {
      return Left("An erorr occurred");
    }
  }

  @override
  Future<Either<String, UserEntity>> tunOnOrTurnOffBiometrics() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      if (user == null) {
        return Left("User is not logged in.");
      }

      // Request biometric authentication (Face ID or fingerprint)
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to enable/disable biometrics',
        options: AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction:
              true, // Only allow biometric authentication (Face ID/Fingerprint)
        ),
      );

      if (!isAuthenticated) {
        return Left("Biometric authentication failed.");
      }

      // Truy vấn người dùng từ Firestore
      var userDocSnapshot =
          await firebaseFirestore.collection('Users').doc(user.uid).get();

      if (!userDocSnapshot.exists) {
        return Left("No user found with the given UID in Firestore.");
      }

      var userData = userDocSnapshot.data();
      if (userData == null) {
        return Left("User data is null.");
      }

      // Lấy trạng thái `isBiometrics` hiện tại và cập nhật lại
      bool isBiometrics = userData['isBiometrics'] ?? false;

      // Cập nhật trạng thái `isBiometrics` trong Firestore
      await firebaseFirestore.collection('Users').doc(user.uid).update({
        'isBiometrics': !isBiometrics,
      });

      // Cập nhật lại đối tượng người dùng và trả về
      UserModel userModel = UserModel.fromeJson(userData);
      userModel.imageUrl = user.photoURL ?? AppUrls.defaultImage;
      userModel.isBiometrics = !isBiometrics; // Đảo ngược trạng thái
      UserEntity userEntity = userModel.toEntity();

      return Right(userEntity);
    } catch (e) {
      return Left("An error occurred: $e");
    }
  }
}
