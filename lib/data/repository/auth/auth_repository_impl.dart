import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/data/models/signup_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firevase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    return await sl<AuthFirebaseService>().signIn(signInUserReq);
  }

  @override
  Future<Either> signup(SignupUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }
}
