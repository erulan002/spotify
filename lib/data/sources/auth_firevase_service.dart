import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify/data/models/create_user_req.dart';

abstract class AuthFirevaseService {
  Future<void> signup(CreateUserReq createUserReq);

  Future<void> signin();
}

class AuthFirevaseServiceImpl extends AuthFirevaseService {
  @override
  Future<void> signin() {
    throw UnimplementedError();
  }

  @override
  Future<void> signup(CreateUserReq createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );
    } on FirebaseAuthException catch (e) {}
  }
}
