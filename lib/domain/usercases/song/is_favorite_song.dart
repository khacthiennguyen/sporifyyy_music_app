import 'package:sporifyyy/core/usecases/usecase.dart';

import 'package:sporifyyy/domain/repository/song/song.dart';
import 'package:sporifyyy/service_locator.dart';

class IsFavoriteSongUseCase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoritesSong(params!);
  }
}
