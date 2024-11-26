import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporifyyy/data/models/song/song.dart';
import 'package:sporifyyy/domain/entities/song/song.dart';
import 'package:sporifyyy/domain/usercases/song/is_favorite_song.dart';
import 'package:sporifyyy/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavorite(String songId);
  Future<bool> isFavariteSong(String songId);
  Future<Either> getUserFavoriteSong();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .limit(4)
          .orderBy('releaseDate', descending: false)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromeJson(element.data());
        bool isFavorites = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorites;
        songModel.songId = element.reference.id;
        // print(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return const Left("An error occurred, Please try a");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromeJson(element.data());
        bool isFavorites = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorites;
        songModel.songId = element.reference.id;
        // print(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return const Left("An error occurred, Please try again");
    }
  }

  @override
  Future<Either> addOrRemoveFavorite(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorites;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoritesSong = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where(
            'songId',
            isEqualTo: songId,
          )
          .get();

      if (favoritesSong.docs.isNotEmpty) {
        await favoritesSong.docs.first.reference.delete();
        isFavorites = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addDate': Timestamp.now()});

        isFavorites = true;
      }

      return Right(isFavorites);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavariteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoritesSong = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where(
            'songId',
            isEqualTo: songId,
          )
          .get();

      if (favoritesSong.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSong() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      List<SongEntity> favoriteSong = [];

      QuerySnapshot favoriteSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();

       print("Number of documents: ${favoriteSnapshot.docs.length}");

      for (var element in favoriteSnapshot.docs) {
        String songId = element['songId'];

        var song =
            await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromeJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSong.add(songModel.toEntity());
      }

      return Right(favoriteSong);
    } catch (e) {
      return const Left('An error occurred');
    }
  }
}
