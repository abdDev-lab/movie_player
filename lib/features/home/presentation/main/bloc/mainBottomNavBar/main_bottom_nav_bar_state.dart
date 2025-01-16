part of 'main_bottom_nav_bar_cubit.dart';

class MainBottomNavBarState extends Equatable {
  final int currentMainPage;

  const MainBottomNavBarState({this.currentMainPage = 0});

  @override
  List<Object> get props => [currentMainPage];
}
