import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/network/failures.dart';
import '../../../domain/entity/search_entitiy.dart';
import '../../../domain/usecases/get_recomand_search_usecase.dart';

part 'recomand_search_state.dart';

class RecomandSearchCubit extends Cubit<RecomandSearchState> {
  final GetRecomandSearchUsecase getRecomandSearchUsecase;
  RecomandSearchCubit(this.getRecomandSearchUsecase)
      : super(RecomandSearchInitial());

  void getRecomandMedia(TextEditingController searchEditingController) async {
    emit(LoadingState());
    final recomandSearchList =
        await getRecomandSearchUsecase.call(searchEditingController.text);
    emit(mapFailureOrSuccessSearchState(
        recomandSearchList, searchEditingController));
  }

  RecomandSearchState mapFailureOrSuccessSearchState(
      Either<Failures, Map> failureOrSearchList,
      TextEditingController searchEditingController) {
    return failureOrSearchList.fold(
      (failure) {
        return ErrorState(message: mapFailureToMessage(failure));
      },
      (searchList) {
        return LoadedRecomandSearchListState(
            searchEditingController: searchEditingController,
            recomandMedia: searchList["media"],
            keywords: searchList["keyword"]);
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
