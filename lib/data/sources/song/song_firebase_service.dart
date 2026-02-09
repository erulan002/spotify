import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song.dart';
import 'package:spotify/domain/entities/song.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

import '../../../service_locator.dart';

abstract class SongsFirebaseService {
  Future<Either> getNewsSongs();

  Future<Either> getPlayList();

  Future<Either> addOrRemoveFavoriteSong(String songId);

  Future<bool> isFavoriteSong(String songId);
}

class SongsFirebaseServiceImpl extends SongsFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy(
            'release',
            descending: true,
          )
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (error) {
      return const Left('An error ocurred. Please try again.');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy(
            'release',
            descending: true,
          )
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        final isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (error) {
      return const Left('An error ocurred. Please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      bool isFavorite = false;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where(
            'songId',
            isEqualTo: songId,
          )
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add(
          {
            "songId": songId,
            "addedDate": Timestamp.now(),
          },
        );
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left('An error ocurred');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uID = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uID)
          .collection('Favorites')
          .where(
            'songId',
            isEqualTo: songId,
          )
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
