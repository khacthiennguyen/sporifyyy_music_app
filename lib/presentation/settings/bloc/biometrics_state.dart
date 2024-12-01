import 'package:sporifyyy/domain/entities/auth/user.dart';

abstract class BiometricsState {}

class BiometricsLoading extends BiometricsState {}

class BiometricsLoaded extends BiometricsState {
  final UserEntity userEntity;


  BiometricsLoaded({ required this.userEntity});
}

class BiometricsFailure extends BiometricsState {}
