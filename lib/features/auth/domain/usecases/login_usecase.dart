// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:movieplayer/core/network/failures.dart';
import 'package:movieplayer/features/auth/domain/entites/user.dart';
import 'package:movieplayer/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase(
    this.authRepository,
  );

  Future<Either<User, Failures>> call(String email, String password) async {
    return await authRepository.login(password, email);
  }
}
