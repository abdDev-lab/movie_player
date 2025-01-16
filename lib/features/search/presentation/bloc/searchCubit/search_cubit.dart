import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/network/failures.dart';
import '../../../../../core/shared/entities/tranding_entity.dart';
import '../../../domain/entity/search_entitiy.dart';
import '../../../domain/usecases/get_searched_media_usecase.dart';
import '../../../domain/usecases/get_tranding_media_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchedMediaUseCase getSearchedMediaUseCase;
  final GetTrandingMediaUsecase getTrandingMediaUsecase;

  SearchCubit(
    this.getSearchedMediaUseCase,
    this.getTrandingMediaUsecase,
  ) : super(SearchInitial());

  void getSearchedMedia(String searchInput) async {
    emit(SearchLoadingState());
    final failureOrSuccessSearch =
        await getSearchedMediaUseCase.call(searchInput);
    emit(mapFailureOrSuccessSearchState(failureOrSuccessSearch, searchInput));
  }

  void getTrandingMedia() async {
    emit(SearchLoadingState());
    final failureOrSuccess = await getTrandingMediaUsecase.call();
    emit(mapFailureOrTrandingState(failureOrSuccess));
  }

  SearchState mapFailureOrSuccessSearchState(
      Either<Failures, List<SearchEntity>> failureOrShows, String searchInput) {
    return failureOrShows.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (searchList) {
        return LoadedSearchListState(
            searchInput: searchInput, searchList: searchList);
      },
    );
  }

  SearchState mapFailureOrTrandingState(
      Either<Failures, List<Tranding>> failureOrShows) {
    return failureOrShows.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (media) {
        return LoadedTrandingMediaState(media: media);
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
