import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/domain/usercases/auth/get_user.dart';
import 'package:sporifyyy/domain/usercases/auth/turn_on_or_turn_off_biometrics.dart';
import 'package:sporifyyy/presentation/settings/bloc/biometrics_state.dart';
import 'package:sporifyyy/service_locator.dart';

class BiometricsCubit extends Cubit<BiometricsState> {
  BiometricsCubit() : super(BiometricsLoading());

  Future<void> getuser() async {
    var user = await sl<GetUserUseCase>().call();
    user.fold((f) {
      emit(BiometricsFailure());
    }, (userEntity) {
      emit(BiometricsLoaded(userEntity: userEntity));
    });
  }

  void updateBiometricsStatus() async {
    var result = await sl<TurnOnOrTurnOffBiometricsUseCase>().call();
    result.fold((f) {
      emit(BiometricsFailure());
    }, (userEntity) {
      emit(BiometricsLoaded(userEntity: userEntity)); // Cập nhật lại thông tin người dùng
    });
  }
}
