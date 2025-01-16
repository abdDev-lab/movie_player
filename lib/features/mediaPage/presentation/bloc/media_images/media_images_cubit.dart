import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/network/failures.dart';
import '../../../domain/usecases/get_media_images_usecase.dart';

part 'media_images_state.dart';

class MediaImagesCubit extends Cubit<MediaImagesState> {
  final GetMediaImagesUsecase getMediaImagesUsecase;
  MediaImagesCubit(this.getMediaImagesUsecase) : super(MediaImagesInitial());

  void getMediaImages(int mediaId, String mediaType) async {
    emit(LoadingState());
    final failureOrSuccess = await getMediaImagesUsecase.call(mediaId, mediaType);
    emit(mapFailureOrMediaImagesToState(failureOrSuccess));
  }
  MediaImagesState mapFailureOrMediaImagesToState(
      Either<Failures, List<String>> failureOrSuccess) {
    return failureOrSuccess.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (images) {
        return LoadedMediaImages(mediaImages: images);
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
