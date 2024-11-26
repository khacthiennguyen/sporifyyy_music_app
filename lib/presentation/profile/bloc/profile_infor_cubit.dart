import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sporifyyy/domain/usercases/auth/get_user.dart';
import 'package:sporifyyy/presentation/profile/bloc/profile_infor_state.dart';
import 'package:sporifyyy/service_locator.dart';

class ProfileInforCubit extends Cubit<ProfileInforState> {
  ProfileInforCubit() : super(ProfileInforLoading());

  Future<void> getuser() async {
    var user = await sl<GetUserUseCase>().call();

    user.fold((f) {
      emit(ProfileInforFailure());
    }, (userEntity) {
      emit (ProfileInforLoaded(userEntity: userEntity));
    });
  }
}
