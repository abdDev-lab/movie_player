import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/network/failures.dart';

import '../../../../../../core/shared/entities/tranding_entity.dart';

import '../../../../domain/usecases/get_tranding_usecase.dart';

part 'tranding_movies_state.dart';

class TrandingCubit extends Cubit<TrandingState> {
  final GetTrandingUsecase getTrandingUsecase;
  late Timer timer;
  TrandingCubit(this.getTrandingUsecase) : super(TrandingInitial());

  void getTrandingMovies() async {
    emit(LoadingState());
    final trandingMovies = await getTrandingUsecase.call();
    emit(mapFailureOrMoviesToState(trandingMovies));
    autoScrollingTrandingMovies();
  }

  void scrollingTrandingMovies(int pageIndex) {
    if (state is LoadedTrandingState) {
      final currentState = state as LoadedTrandingState;
      emit(currentState.copyWith(pageIndex: pageIndex));
    }
  }

  void autoScrollingTrandingMovies() {
    if (state is LoadedTrandingState) {
      timer = Timer.periodic(
        const Duration(seconds: 5),
        (timer) {
          final currentState = state as LoadedTrandingState;
          if (currentState.pageIndex >= 6) {
            emit(currentState.copyWith(pageIndex: 0));
          } else {
            emit(currentState.copyWith(pageIndex: currentState.pageIndex + 1));
          }
        },
      );
    }
  }

  TrandingState mapFailureOrMoviesToState(
      Either<Failures, List<Tranding>> failureOrMovies) {
    return failureOrMovies.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (trandings) {
        return LoadedTrandingState(
          0,
          tranding: trandings,
        );
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
  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }
}
