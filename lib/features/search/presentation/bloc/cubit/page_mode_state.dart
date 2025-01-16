part of 'page_mode_cubit.dart';

sealed class PageModeState extends Equatable {
  const PageModeState();

  @override
  List<Object> get props => [];
}

final class PageModeInitial extends PageModeState {}
final class SearchModeState extends PageModeState {}
final class BrowseModeState extends PageModeState {}


