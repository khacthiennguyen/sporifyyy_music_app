import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/domain/usercases/song/get_play_list.dart';
import 'package:sporifyyy/presentation/home/bloc/play_list_state.dart';
import 'package:sporifyyy/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());
  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold((l) {
      emit(PlayListLoadFailure());
    }, (data) {
      emit(PlayListLoaded(songs: data));
    });
  }
}
