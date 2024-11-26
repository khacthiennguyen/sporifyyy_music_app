import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/domain/entities/song/song.dart';
import 'package:sporifyyy/domain/usercases/song/get_favorite_song.dart';
import 'package:sporifyyy/presentation/profile/bloc/favorite_song_state.dart';
import 'package:sporifyyy/service_locator.dart';

class FavoriteSongCubit extends Cubit<FavoriteSongState> {
  FavoriteSongCubit() : super(FavoreiteSongLoading());

  List<SongEntity> favoriteSong = [];

  Future<void> getFavoriteSong() async {
    var result = await sl<GetFavoriteSongsUseCase>().call();

    result.fold((l) {
      emit(FavoreiteSongFalure());
    }, (r) {
      favoriteSong = r;
      emit(FavoreiteSongLoaded(favoriteSong: favoriteSong));
    });
  }

  void removeSong(int index) {
    favoriteSong.removeAt(index);
    emit(FavoreiteSongLoaded(favoriteSong: favoriteSong));
  }
}
