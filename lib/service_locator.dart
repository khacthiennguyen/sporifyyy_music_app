import 'package:get_it/get_it.dart';
import 'package:sporifyyy/data/repository/auth/auth_repository_impl.dart';
import 'package:sporifyyy/data/repository/song/song_repository_impl.dart';

import 'package:sporifyyy/data/sources/auth/auth_firebase_service.dart';
import 'package:sporifyyy/data/sources/song/song_firebase_service.dart';
import 'package:sporifyyy/domain/repository/auth/auth.dart';
import 'package:sporifyyy/domain/repository/song/song.dart';
import 'package:sporifyyy/domain/usercases/auth/get_user.dart';

import 'package:sporifyyy/domain/usercases/auth/signin.dart';
import 'package:sporifyyy/domain/usercases/auth/signup.dart';
import 'package:sporifyyy/domain/usercases/song/add_or_remove_favorite_song.dart';
import 'package:sporifyyy/domain/usercases/song/get_favorite_song.dart';
import 'package:sporifyyy/domain/usercases/song/get_news_songs.dart';
import 'package:sporifyyy/domain/usercases/song/get_play_list.dart';
import 'package:sporifyyy/domain/usercases/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> initialzeDependencies() async {
//auth service sl

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

//song
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase());

  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());
}
