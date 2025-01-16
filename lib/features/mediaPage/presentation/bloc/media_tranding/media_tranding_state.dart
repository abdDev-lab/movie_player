part of 'media_tranding_cubit.dart';

sealed class MediaTrandingState extends Equatable {
  const MediaTrandingState();

  @override
  List<Object> get props => [];
}

final class MediaTrandingInitial extends MediaTrandingState {}

final class LoadingState extends MediaTrandingState {}

final class LoadedMediaTrandingState extends MediaTrandingState {
  final List<Tranding> mediaTranding;

  const LoadedMediaTrandingState({required this.mediaTranding});
  @override
  List<Object> get props => [mediaTranding];
}

final class ErrorState extends MediaTrandingState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
