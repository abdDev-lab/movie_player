import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_bottom_nav_bar_state.dart';

class MainBottomNavBarCubit extends Cubit<MainBottomNavBarState> {
  MainBottomNavBarCubit() : super(const MainBottomNavBarState());

  void changeMainPage(int selectedPage) {
    emit(MainBottomNavBarState(currentMainPage: selectedPage));
  }
}
