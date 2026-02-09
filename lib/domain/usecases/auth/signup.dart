import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/signup_user_req.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class SignupUseCase implements UseCase<Either, SignupUserReq> {
  @override
  Future<Either> call({SignupUserReq? params}) {
    return sl<AuthRepository>().signup(params!);
  }
}
