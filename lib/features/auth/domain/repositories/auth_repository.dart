import "package:dartz/dartz.dart";
import "../../../../core/network/failures.dart";
import "../entites/user.dart";

abstract class AuthRepository {
  Future<Either<User, Failures>> login(String password, String email);
}
