import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_mode_state.dart';

class PageModeCubit extends Cubit<PageModeState> {
  PageModeCubit() : super(PageModeInitial());

  void searchMode() {
    emit(SearchModeState());
  }

  void borwseMode() {
    emit(BrowseModeState());
  }
}
