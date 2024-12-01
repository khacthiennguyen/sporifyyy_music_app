import 'package:sporifyyy/domain/entities/auth/user.dart';

class UserModel {
  String? userId;
  String? fullName;
  String? email;
  String? imageUrl;
  bool? isBiometrics;

  UserModel({
    this.userId,
    this.imageUrl,
    this.fullName,
    this.email,
    this.isBiometrics,
  });

  UserModel.fromeJson(Map<String, dynamic> data) {
    userId = data['userId'];
    fullName = data['name'];
    email = data['email'];
    isBiometrics = data['isBiometrics'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      imageUrl: imageUrl,
      isBiometric: isBiometrics,
    );
  }
}
