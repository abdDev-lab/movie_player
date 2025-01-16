import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordState(false)) {
    on<PasswordEvent>((event, emit) {
      if (event is ChangeShowPasswordEvent) {
        emit(PasswordState(!state.showPassword));
      }
    });
  }
}
