import 'package:dartz/dartz.dart';
import 'package:sporifyyy/data/sources/song/song_firebase_service.dart';
import 'package:sporifyyy/domain/repository/song/song.dart';
import 'package:sporifyyy/service_locator.dart';

class SongRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavorite(songId);
  }

  @override
  Future<bool> isFavoritesSong(String songId) async {
    return await sl<SongFirebaseService>().isFavariteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSong() async {
    return await sl<SongFirebaseService>().getUserFavoriteSong();
  }
}
