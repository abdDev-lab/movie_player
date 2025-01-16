part of 'menu_app_bar_cubit.dart';

sealed class MenuAppBarState extends Equatable {
  const MenuAppBarState();

  @override
  List<Object> get props => [];
}

final class MenuAppBarInitial extends MenuAppBarState {}

final class CategoryState extends MenuAppBarState {
  final int categoryIndex;

  const CategoryState({this.categoryIndex = 0});
  @override
  List<Object> get props => [categoryIndex];
}