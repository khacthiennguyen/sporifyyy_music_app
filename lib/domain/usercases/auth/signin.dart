import 'package:sporifyyy/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sporifyyy/data/models/auth/signin_user_req.dart';
import 'package:sporifyyy/domain/repository/auth/auth.dart';
import 'package:sporifyyy/service_locator.dart';

class SigninUseCase implements Usecase<Either, SigninUserReq> {


  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
  