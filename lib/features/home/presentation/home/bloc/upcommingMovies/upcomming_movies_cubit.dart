import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/network/failures.dart';
import '../../../../../../core/shared/entities/movie_entity.dart';
import '../../../../domain/usecases/get_upcoming_movies_usecase.dart';

part 'upcomming_movies_state.dart';

class UpcommingMoviesCubit extends Cubit<UpcommingMoviesState> {
  final GetUpCommingMoviesUsecase getUpCommingMoviesUsecase;
  UpcommingMoviesCubit(this.getUpCommingMoviesUsecase)
      : super(UpcommingMoviesInitial());

  void getUpComingMovies() async {
    emit(LoadingState());
    final failureOrMovies = await getUpCommingMoviesUsecase.call();
    emit(mapFailureOrMoviesToState(failureOrMovies));
  }

  UpcommingMoviesState mapFailureOrMoviesToState(
      Either<Failures, List<Movie>> failureOrMovies) {
    return failureOrMovies.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (movies) {
        return LoadedUpCommingMoviesState(upCommingMovies: movies);
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
