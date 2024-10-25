import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth_firevase_service.dart';
import 'package:spotify/domain/repository/auth.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirevaseService>(AuthFirevaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
