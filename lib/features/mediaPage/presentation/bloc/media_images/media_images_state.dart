part of 'media_images_cubit.dart';

sealed class MediaImagesState extends Equatable {
  const MediaImagesState();

  @override
  List<Object> get props => [];
}

final class MediaImagesInitial extends MediaImagesState {}
final class LoadingState extends MediaImagesState {}

final class LoadedMediaImages extends MediaImagesState {
  final List<String> mediaImages;

  const LoadedMediaImages({required this.mediaImages});
  @override
  List<Object> get props => [];
}

final class ErrorState extends MediaImagesState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [];
}
