import 'package:sporifyyy/domain/entities/song/song.dart';

abstract class FavoriteSongState {}

class FavoreiteSongLoading extends FavoriteSongState {}

class FavoreiteSongLoaded extends FavoriteSongState {
  final List<SongEntity> favoriteSong ;

  FavoreiteSongLoaded({required this.favoriteSong});
}

class FavoreiteSongFalure extends FavoriteSongState {}

