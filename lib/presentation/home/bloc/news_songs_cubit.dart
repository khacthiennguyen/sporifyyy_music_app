import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/domain/usercases/song/get_news_songs.dart';
import 'package:sporifyyy/presentation/home/bloc/news_songs_state.dart';
import 'package:sporifyyy/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());
  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();
    returnedSongs.fold((l) {
      emit(NewsSongsLoadFailure());
    }, (data) {
      emit(NewsSongsLoaded(songs: data));
    });
  }
}
