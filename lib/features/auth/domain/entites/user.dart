import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String userName;
  final String email;

  const User({
    required this.userId,
    required this.userName,
    required this.email,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
