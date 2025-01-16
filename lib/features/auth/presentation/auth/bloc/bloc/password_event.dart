part of 'password_bloc.dart';

sealed class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangeShowPasswordEvent extends PasswordEvent {
  const ChangeShowPasswordEvent();
}
