part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}
final class LoadedTrandingMediaState extends SearchState {
  final List<Tranding> media;

  const LoadedTrandingMediaState({required this.media});
  @override
  List<Object> get props => [media];
}

final class LoadedSearchListState extends SearchState {
  final String searchInput ;
  final List<SearchEntity> searchList;

  const LoadedSearchListState({required this.searchInput,required this.searchList});
  @override
  List<Object> get props => [searchList,searchInput];
}

final class EmptySearchListState extends SearchState {}

final class ErrorState extends SearchState {
  final String message;
  const ErrorState({required this.message});
}
