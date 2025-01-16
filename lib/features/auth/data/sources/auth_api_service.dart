import '../../../../core/network/exeptions.dart';
import '../models/user_model.dart';

abstract class AuthApiService {
  Future<UserModel> login(String email, String password);
}

class AuthApiServiceImpWithDio extends AuthApiService {

  AuthApiServiceImpWithDio();

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == "abdou@gmail.com" && password == "12345678") {
      final jsonData = {
        "user_id": 1,
        "username": "abdouche",
        "user_email": "abdou@gmail.com"
      };
      return UserModel.fromJson(jsonData);
    } else {
      throw WrongPasswordException();
    }
  }
}
