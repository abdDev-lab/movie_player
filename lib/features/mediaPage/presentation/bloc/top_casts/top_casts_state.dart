part of 'top_casts_cubit.dart';

sealed class TopCastsState extends Equatable {
  const TopCastsState();

  @override
  List<Object> get props => [];
}

final class TopCastsInitial extends TopCastsState {}
final class LoadingState extends TopCastsState {}

final class LoadedMediaCasts extends TopCastsState {
  final List<Credit> mediaCredit;

  const LoadedMediaCasts({required this.mediaCredit});
  @override
  List<Object> get props => [];
}

final class ErrorState extends TopCastsState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [];
}