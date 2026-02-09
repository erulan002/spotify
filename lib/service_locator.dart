import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/song/song_repository_impl.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/domain/usecases/song/get_play_list.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/sources/auth/auth_firevase_service.dart';
import 'data/sources/song/song_firebase_service.dart';
import 'domain/repository/auth/auth_repository.dart';
import 'domain/repository/song/song_repository.dart';
import 'domain/usecases/auth/signIn.dart';
import 'domain/usecases/auth/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<SongsFirebaseService>(SongsFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SongsRepository>(SongsRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase());

  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
}
