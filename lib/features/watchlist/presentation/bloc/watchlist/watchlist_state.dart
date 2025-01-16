part of 'watchlist_cubit.dart';

sealed class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

final class WatchlistInitial extends WatchlistState {}

final class LoadingState extends WatchlistState {}

final class LoadedWatchlistMoviesState extends WatchlistState {
  final List<Movie> watchlistMovies;

  const LoadedWatchlistMoviesState({required this.watchlistMovies});

  @override
  List<Object> get props => [watchlistMovies];
}

final class LoadedWatchlistTvState extends WatchlistState {
  final List<TV> watchlistTv;

  const LoadedWatchlistTvState({required this.watchlistTv});

  @override
  List<Object> get props => [watchlistTv];
}

final class ErrorState extends WatchlistState {
  final String message;
  const ErrorState({required this.message});
}
