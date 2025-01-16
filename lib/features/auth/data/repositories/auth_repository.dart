// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:dartz/dartz.dart";
import 'package:movieplayer/core/network/exeptions.dart';
import 'package:movieplayer/core/network/failures.dart';
import 'package:movieplayer/core/network/network_info.dart';

import 'package:movieplayer/features/auth/data/sources/auth_api_service.dart';
import 'package:movieplayer/features/auth/domain/entites/user.dart';
import 'package:movieplayer/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthApiService authApiService;
  final NetworkInfo networkInfo;
  AuthRepositoryImp({required this.authApiService, required this.networkInfo});

  @override
  Future<Either<User, Failures>> login(String password, String email) async {
    if (await networkInfo.isConnected) {
      try {
        final userData = await authApiService.login(email, password);
        return Left(userData);
      } on ServerException {
        return Right(ServerFailure());
      } on WrongPasswordException {
        return Right(WrongPassword());
      }
    } else {
      return Right(OfflineFailure());
    }
  }
}
