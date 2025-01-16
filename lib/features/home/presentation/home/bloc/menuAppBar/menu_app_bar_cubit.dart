import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_app_bar_state.dart';

class MenuAppBarCubit extends Cubit<MenuAppBarState> {
  MenuAppBarCubit() : super(MenuAppBarInitial());

  void selectCategory(int categoryIndex) {
    emit(CategoryState(categoryIndex: categoryIndex));
  }
}
