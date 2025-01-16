part of 'tranding_movies_cubit.dart';

sealed class TrandingState extends Equatable {
  const TrandingState();

  @override
  List<Object> get props => [];
}

final class TrandingInitial extends TrandingState {}

final class LoadingState extends TrandingState {}

final class LoadedTrandingState extends TrandingState {
  final List<Tranding> tranding;
  final int pageIndex;
  const LoadedTrandingState(this.pageIndex,
      {required this.tranding});

  LoadedTrandingState copyWith({int? pageIndex}) {
    return LoadedTrandingState(pageIndex ?? this.pageIndex,
        tranding: tranding);
  }

  @override
  List<Object> get props => [tranding, pageIndex];
}

final class ErrorState extends TrandingState {
  final String message;
  const ErrorState({required this.message});
}
