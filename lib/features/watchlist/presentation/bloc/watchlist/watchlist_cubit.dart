import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/failures.dart';
import '../../../../../core/shared/entities/movie_entity.dart';
import '../../../../../core/shared/entities/tv_entity.dart';
import '../../../../home/domain/usecases/remove_from_watchlist_usecase.dart';
import '../../../domain/usecase/get_watchlist_movie_usecase.dart';
import '../../../domain/usecase/get_watchlist_tv_usecase.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final GetWatchlistMovieUsecase getWatchlistMovieUsecase;
  final GetWatchlistTvUsecase getWatchlistTvUsecase;
  final RemoveFromWatchlistUsecase removeFromWatchlistUsecase;

  WatchlistCubit(this.getWatchlistMovieUsecase, this.getWatchlistTvUsecase,
      this.removeFromWatchlistUsecase)
      : super(WatchlistInitial());
  void getWatchlistMovies() async {
    emit(LoadingState());
    final failureOrMovies = await getWatchlistMovieUsecase.call();
    emit(mapFailureOrMoviesToState(failureOrMovies));
  }

  void getWatchlistShows() async {
    emit(LoadingState());
    final failureOrShows = await getWatchlistTvUsecase.call();
    emit(mapFailureOrTvToState(failureOrShows));
  }

  void removeFromMovieWatchList(int mediaId, List<Movie> oldWatchList) async {
    List<Movie> newWatchList = oldWatchList;
    newWatchList.removeWhere(
      (movie) => movie.id == mediaId,
    );
    emit(WatchlistInitial());
    emit(LoadedWatchlistMoviesState(watchlistMovies: newWatchList));
    final isRemoved = await removeFromWatchlistUsecase.call(mediaId, "movie");
    if (isRemoved is Failures) {
      emit(WatchlistInitial());
      emit(LoadedWatchlistMoviesState(watchlistMovies: oldWatchList));
    }
  }

  void removeFromTvWatchList(int mediaId, List<TV> oldWatchList) async {
    List<TV> newWatchList = oldWatchList;
    newWatchList.removeWhere(
      (show) => show.id == mediaId,
    );
    emit(WatchlistInitial());
    emit(LoadedWatchlistTvState(watchlistTv: newWatchList));
    final isRemoved = await removeFromWatchlistUsecase.call(mediaId, "tv");
    if (isRemoved is Failures) {
      emit(WatchlistInitial());
      emit(LoadedWatchlistTvState(watchlistTv: oldWatchList));
    }
  }

  WatchlistState mapFailureOrMoviesToState(
      Either<Failures, List<Movie>> failureOrMovies) {
    return failureOrMovies.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (movies) {
        return LoadedWatchlistMoviesState(watchlistMovies: movies);
      },
    );
  }

  WatchlistState mapFailureOrTvToState(
      Either<Failures, List<TV>> failureOrShows) {
    return failureOrShows.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (shows) {
        return LoadedWatchlistTvState(watchlistTv: shows);
      },
    );
  }

  String mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure():
        return "There is problem in Server";
      case OfflineFailure():
        return "There is no Connection";
      default:
        return "Unexepted Error, Please try again later .";
    }
  }
}
