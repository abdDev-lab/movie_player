part of 'foryou_cubit.dart';

sealed class ForyouState extends Equatable {
  const ForyouState();

  @override
  List<Object> get props => [];
}

final class ForyouInitial extends ForyouState {


}

final class LoadingState extends ForyouState {}

final class LoadedForyouMoviesState extends ForyouState {
  final List<Movie> foryouMovies;

  const LoadedForyouMoviesState({required this.foryouMovies});

  @override
  List<Object> get props => [foryouMovies];
}

final class LoadedForyouTvState extends ForyouState {
  final List<TV> foryouTv;

  const LoadedForyouTvState({required this.foryouTv});

  @override
  List<Object> get props => [foryouTv];
}

final class ErrorState extends ForyouState {
  final String message;
  const ErrorState({required this.message});
}
