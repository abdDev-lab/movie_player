import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/network/failures.dart';
import '../../../domain/entities/media.dart';
import '../../../domain/usecases/get_media_credit_usecases.dart';

part 'top_casts_state.dart';

class TopCastsCubit extends Cubit<TopCastsState> {
  final GetMediaCreditUsecases getMediaCreditUsecases;
  TopCastsCubit(this.getMediaCreditUsecases) : super(TopCastsInitial());

  void getMediaCasts(int mediaId, String mediaType) async {
    emit(LoadingState());
    final failureOrSuccess =
        await getMediaCreditUsecases.call(mediaId, mediaType);
    emit(mapFailureOrMediaCastsToState(failureOrSuccess));
  }

  TopCastsState mapFailureOrMediaCastsToState(
      Either<Failures, List<Credit>> failureOrSuccess) {
    return failureOrSuccess.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (trailer) {
        return LoadedMediaCasts(mediaCredit: trailer);
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
