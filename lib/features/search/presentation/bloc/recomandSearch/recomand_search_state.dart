part of 'recomand_search_cubit.dart';

sealed class RecomandSearchState extends Equatable {
  const RecomandSearchState();

  @override
  List<Object> get props => [];
}

final class RecomandSearchInitial extends RecomandSearchState {}

final class LoadingState extends RecomandSearchState {}

final class LoadedRecomandSearchListState extends RecomandSearchState {
  final TextEditingController searchEditingController;
  final List<SearchEntity> recomandMedia;
  final List<String> keywords;

  const LoadedRecomandSearchListState(
      {required this.searchEditingController,
      required this.recomandMedia,
      required this.keywords});

  @override
  List<Object> get props => [recomandMedia, keywords, searchEditingController];
}

final class EmptySearchListState extends RecomandSearchState {}

final class ErrorState extends RecomandSearchState {
  final String message;
  const ErrorState({required this.message});
}
