import 'package:sporifyyy/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sporifyyy/domain/repository/song/song.dart';
import 'package:sporifyyy/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongsRepository>().addOrRemoveFavoriteSong(params!);
  }
 
}
