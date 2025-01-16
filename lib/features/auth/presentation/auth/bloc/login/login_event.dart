part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PressLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const PressLoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
