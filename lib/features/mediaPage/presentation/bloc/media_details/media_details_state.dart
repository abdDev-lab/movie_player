part of 'media_details_cubit.dart';

sealed class MediaDetailsState extends Equatable {
  const MediaDetailsState();

  @override
  List<Object> get props => [];
}

final class MediaDetailsInitial extends MediaDetailsState {}


final class LoadedMediaGenresState extends MediaDetailsState {
  final MediaGenres mediaGenres;

  const LoadedMediaGenresState({required this.mediaGenres});
  @override
  List<Object> get props => [];
} 

final class ErrorState extends MediaDetailsState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [];
}
