import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/data/models/signup_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupUserReq createUserReq);

  Future<Either> signIn(SignInUserReq signInUserReq);
}
