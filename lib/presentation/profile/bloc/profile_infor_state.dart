import 'package:sporifyyy/domain/entities/auth/user.dart';

abstract class ProfileInforState {}

class ProfileInforLoading extends ProfileInforState{}
class ProfileInforLoaded extends ProfileInforState{
   final UserEntity userEntity;

  ProfileInforLoaded({required this.userEntity});
}
class ProfileInforFailure extends ProfileInforState{}