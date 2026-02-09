import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/data/models/signup_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(SignupUserReq createUserReq);

  Future<Either> signIn(SignInUserReq signInUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email,
        password: signInUserReq.password,
      );

      return const Right('Sign In was Successful');
    } on FirebaseAuthException catch (error) {
      String message = '';

      if (error.code == 'invalid-email') {
        message = 'Not user found for that email';
      } else if (error.code == 'invalid-credential') {
        message = 'Wrong password provided for that email';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signup(SignupUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

      return const Right('Signup was Successful');
    } on FirebaseAuthException catch (error) {
      String message = '';

      if (error.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (error.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      }

      return Left(message);
    }
  }
}
