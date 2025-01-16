part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoadingState extends LoginState {}

final class SuccessLoginState extends LoginState {}

final class ErrorState extends LoginState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

