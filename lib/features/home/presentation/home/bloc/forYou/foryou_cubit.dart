import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/network/failures.dart';
import '../../../../../../core/shared/entities/movie_entity.dart';
import '../../../../../../core/shared/entities/tv_entity.dart';
import '../../../../domain/usecases/get_foryou_movies_usecase.dart';
import '../../../../domain/usecases/get_foryou_tv_usecase.dart';

part 'foryou_state.dart';

class ForyouCubit extends Cubit<ForyouState> {
  final GetForyouMoviesUsecase getForyouMoviesUsecase;
  final GetForyouTvUsecase getForyouTvUsecase;

  ForyouCubit(this.getForyouMoviesUsecase, this.getForyouTvUsecase)
      : super(ForyouInitial());

  void getForYouMovies() async {
    emit(LoadingState());
    final failureOrMovies = await getForyouMoviesUsecase.call();
    emit(mapFailureOrMoviesToState(failureOrMovies));
  }

  void getForYouShows() async {
    emit(LoadingState());
    final failureOrShows = await getForyouTvUsecase.call();
    emit(mapFailureOrTvToState(failureOrShows));
  }

  ForyouState mapFailureOrMoviesToState(
      Either<Failures, List<Movie>> failureOrMovies) {
    return failureOrMovies.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (movies) {
        return LoadedForyouMoviesState(foryouMovies: movies);
      },
    );
  }

  ForyouState mapFailureOrTvToState(Either<Failures, List<TV>> failureOrShows) {
    return failureOrShows.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (shows) {
        return LoadedForyouTvState(foryouTv: shows);
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
