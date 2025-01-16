import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/network/failures.dart';
import '../../../domain/entities/media.dart';
import '../../../domain/usecases/get_media_trailer_usecases.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'media_trailers_state.dart';

class MediaTrailersCubit extends Cubit<MediaTrailersState> {
  final GetMediaTrailerUsecases getMediaTrailerUsecases;
  late YoutubePlayerController videoPlayerController;
  MediaTrailersCubit(this.getMediaTrailerUsecases)
      : super(MediaTrailersInitial());

  void getMediaTrailer(int mediaId, String mediaType) async {
    emit(LoadingState());
    final failureOrSuccess =
        await getMediaTrailerUsecases.call(mediaId, mediaType);
    failureOrSuccess.fold(
      (failure) {
        emit(ErrorState(message: mapFailureToMessage(failure)));
      },
      (trailer) async {
        videoPlayerController = YoutubePlayerController(
          initialVideoId: trailer.key!,
          flags: const YoutubePlayerFlags(
            useHybridComposition: true,
            
            autoPlay: false,
            mute: false,
            
          ),
        );

        emit(LoadedMediaTrailers(
            youtubePlayerController: videoPlayerController,
            mediaTrailer: trailer));
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
    videoPlayerController.dispose();
    return super.close();
  }
}
