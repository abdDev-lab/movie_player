import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/failures.dart';
import '../../../../../core/shared/entities/tranding_entity.dart';
import '../../../domain/usecases/get_media_trainding_usecase.dart';

part 'media_tranding_state.dart';

class MediaTrandingCubit extends Cubit<MediaTrandingState> {
  final GetMediaTraindingUsecase getMediaTraindingUsecase;
  MediaTrandingCubit(this.getMediaTraindingUsecase)
      : super(MediaTrandingInitial());

  void getMediaTranding(int mediaId) async {
    emit(LoadingState());
    final failureOrSuccess = await getMediaTraindingUsecase.call(mediaId);
    failureOrSuccess.fold(
      (failure) {
        emit(ErrorState(message: mapFailureToMessage(failure)));
      },
      (tranding) {
        emit(LoadedMediaTrandingState(mediaTranding: tranding));
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
