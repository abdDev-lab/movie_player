import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/network/failures.dart';
import '../../../../domain/entites/user.dart';
import '../../../../domain/usecases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  final SharedPreferences sharedPreferences;
  LoginBloc(this.loginUsecase, this.sharedPreferences) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is PressLoginEvent) {
        emit(LoadingState());
        final failureOrSuccess =
            await loginUsecase.call(event.email, event.password);
        emit(failureOrSuccessLogin(failureOrSuccess));
      }
    });
  }

  LoginState failureOrSuccessLogin(Either<User, Failures> failureOrSuccess) {
    return failureOrSuccess.fold((user) {
      sharedPreferences.setBool("AUTHENTICATED", true);
      return SuccessLoginState();
    }, (failure) {
      return ErrorState(mapFailureToMessage(failure));
    });
  }

  String mapFailureToMessage(Failures failure) {
    switch (failure) {
      case ServerFailure():
        return "There is problem in Server";
      case OfflineFailure():
        return "There is no Connection";
      case WrongPassword():
        return "Wrong Password";
      default:
        return "Unexepted Error, Please try again later .";
    }
  }
}
