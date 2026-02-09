import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/song/song_repository.dart';
import 'package:spotify/service_locator.dart';

class GetPlayListUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return sl<SongsRepository>().getPlayList();
  }
}
