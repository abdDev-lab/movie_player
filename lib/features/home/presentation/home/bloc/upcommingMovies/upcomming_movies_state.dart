part of 'upcomming_movies_cubit.dart';

sealed class UpcommingMoviesState extends Equatable {
  const UpcommingMoviesState();

  @override
  List<Object> get props => [];
}

final class UpcommingMoviesInitial extends UpcommingMoviesState {}

final class LoadingState extends UpcommingMoviesState {}

final class LoadedUpCommingMoviesState extends UpcommingMoviesState {
  final List<Movie> upCommingMovies;

  const LoadedUpCommingMoviesState({required this.upCommingMovies});

  @override
  List<Object> get props => [upCommingMovies];
}

final class ErrorState extends UpcommingMoviesState {
  final String message;
  const ErrorState({required this.message});
}
