import '../../domain/entites/user.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.userName,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json["user_id"],
        userName: json["username"],
        email: json["user_email"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': userName,
      'user_email': email,
    };
  }
}
