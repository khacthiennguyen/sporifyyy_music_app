import 'package:sporifyyy/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sporifyyy/domain/repository/auth/auth.dart';
import 'package:sporifyyy/service_locator.dart';

class TurnOnOrTurnOffBiometricsUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String ? params}) async{
    return await sl<AuthRepository>().tunOnOrTurnOffBiometrics();
  }
 
}
