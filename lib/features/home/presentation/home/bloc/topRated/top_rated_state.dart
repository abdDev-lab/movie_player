part of 'top_rated_cubit.dart';

sealed class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

final class TopRatedInitial extends TopRatedState {}

final class LoadingState extends TopRatedState {}

final class LoadedTopRatedState extends TopRatedState {
  final List<Movie> topRated;

  const LoadedTopRatedState({required this.topRated});

  @override
  List<Object> get props => [topRated];
}

final class ErrorState extends TopRatedState {
  final String message;
  const ErrorState({required this.message});
}
