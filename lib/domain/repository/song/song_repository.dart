import 'package:dartz/dartz.dart';

abstract class  SongsRepository {
  Future<Either> getNewsSongs();

  Future<Either> getPlayList();

  Future<Either> addOrRemoveFavoriteSong(String songID);

  Future<bool> isFavoriteSong(String songId);
}
