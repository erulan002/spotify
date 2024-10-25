import 'package:spotify/data/models/create_user_req.dart';

abstract class AuthRepository {
  Future<void> signup(CreateUserReq createUserReq);

  Future<void> signin();
}
