part of 'password_bloc.dart';

 class PasswordState extends Equatable {
  final bool showPassword;
  const PasswordState(this.showPassword);

  @override
  List<Object> get props => [showPassword];
}
