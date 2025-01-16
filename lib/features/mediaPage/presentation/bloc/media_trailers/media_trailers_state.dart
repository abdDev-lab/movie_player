part of 'media_trailers_cubit.dart';

sealed class MediaTrailersState extends Equatable {
  const MediaTrailersState();

  @override
  List<Object> get props => [];
}

final class MediaTrailersInitial extends MediaTrailersState {}

final class LoadingState extends MediaTrailersState {}

final class LoadedMediaTrailers extends MediaTrailersState {
  final YoutubePlayerController youtubePlayerController;
  final Trailer mediaTrailer;

  const LoadedMediaTrailers(
      {required this.youtubePlayerController, required this.mediaTrailer});
  @override
  List<Object> get props => [];
}

final class ErrorState extends MediaTrailersState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [];
}
