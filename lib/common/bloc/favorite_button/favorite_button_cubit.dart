import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:sporifyyy/domain/usercases/song/add_or_remove_favorite_song.dart';
import 'package:sporifyyy/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdate(String songId) async {
    var result = await sl<AddOrRemoveFavoriteSongUseCase>().call(
      params: songId,
    );

    result.fold((f) {}, (isFavorite) {
      emit(FavoriteButtonUpdate(isFavorite: isFavorite));
    });
  }
}
