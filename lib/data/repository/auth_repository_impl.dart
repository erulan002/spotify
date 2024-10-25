import 'package:spotify/data/models/create_user_req.dart';
import 'package:spotify/data/sources/auth_firevase_service.dart';
import 'package:spotify/domain/repository/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<void> signup(CreateUserReq createUserReq) async {
    await sl<AuthFirevaseService>().signup(createUserReq);
  }
}
