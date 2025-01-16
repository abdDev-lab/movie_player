import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/network/failures.dart';
import '../../../../../../core/shared/entities/movie_entity.dart';
import '../../../../domain/usecases/get_top_rated_usecase.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final GetTopRatedUsecase getTopRatedUsecase;
  TopRatedCubit(this.getTopRatedUsecase) : super(TopRatedInitial());

  void getTopRated() async {
    emit(LoadingState());
    final failuresOrTopRated = await getTopRatedUsecase.call();
    emit(mapFailureOrTopRatedToState(failuresOrTopRated));
  }

  TopRatedState mapFailureOrTopRatedToState(
      Either<Failures, List<Movie>> failureOrMovies) {
    return failureOrMovies.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (movies) {
        return LoadedTopRatedState(topRated: movies);
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
