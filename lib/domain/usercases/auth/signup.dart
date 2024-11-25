import 'package:sporifyyy/core/usecases/usecase.dart';
import 'package:sporifyyy/data/models/auth/create_user_req.dart';
import 'package:dartz/dartz.dart';
import 'package:sporifyyy/domain/repository/auth/auth.dart';
import 'package:sporifyyy/service_locator.dart';

class SignupUseCase implements Usecase<Either, CreateUserReq> {


  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
  