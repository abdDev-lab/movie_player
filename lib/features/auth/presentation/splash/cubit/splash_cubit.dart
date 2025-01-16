import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SharedPreferences sharedPreferences;
  SplashCubit(this.sharedPreferences) : super(DisplaySplash());

  void appStarter() async {
    await Future.delayed(const Duration(seconds: 2));
    if (sharedPreferences.getBool("AUTHENTICATED") != null) {
      emit(Authenticated());
    } else {
      emit(NotAuthenticated());
    }
  }
}
