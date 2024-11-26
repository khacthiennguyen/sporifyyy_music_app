import 'package:sporifyyy/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:sporifyyy/domain/repository/song/song.dart';
import 'package:sporifyyy/service_locator.dart';

class GetFavoriteSongsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getUserFavoriteSong();
  }
}
