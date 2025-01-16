import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/network/failures.dart';
import '../../../domain/entities/media.dart';
import '../../../domain/usecases/get_media_genres_usecases.dart';

part 'media_details_state.dart';

class MediaDetailsCubit extends Cubit<MediaDetailsState> {
  final GetMediaGenresUsecases getMediaGenresUsecases;
  MediaDetailsCubit(this.getMediaGenresUsecases) : super(MediaDetailsInitial());

  void getMediaGenres(int mediaId, String mediaType) async {
    final failureOrSuccess =
        await getMediaGenresUsecases.call(mediaId, mediaType);
    emit(mapFailureOrMediaGenresToState(failureOrSuccess));
  }

  MediaDetailsState mapFailureOrMediaGenresToState(
      Either<Failures, MediaGenres> failureOrSuccess) {
    return failureOrSuccess.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (genres) {
        return LoadedMediaGenresState(mediaGenres: genres);
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
