import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/network/failures.dart';
import '../../../../domain/usecases/add_to_watchlist_usecase.dart';
import '../../../../domain/usecases/get_watchlist_usecase.dart';
import '../../../../domain/usecases/remove_from_watchlist_usecase.dart';

part 'watchlist_state.dart';

class WatchlistMediaCubit extends Cubit<WatchlistState> {
  final AddToWatchlistUsecase addToWatchlistUsecase;
  final RemoveFromWatchlistUsecase removeFromWatchlistUsecase;
  final GetWatchListUsecase getWatchListUsecase;
  WatchlistMediaCubit(this.addToWatchlistUsecase,
      this.removeFromWatchlistUsecase, this.getWatchListUsecase)
      : super(const WatchlistState({}));

  void getWatchList() async {
    final watchListOrFailure = await getWatchListUsecase.call();
    watchListOrFailure.fold((failure) {}, (watchList) {
      emit(WatchlistState(watchList));
    });
  }

  void addToWatchList(int mediaId, String mediaType) async {
    Set newWatchList = Set.from(state.watchlist);
    newWatchList.add(mediaId);
    emit(WatchlistState(newWatchList));

    final isAdded = await addToWatchlistUsecase.call(mediaId, mediaType);
    if (isAdded is Failures) {
      newWatchList.remove(mediaId);
      emit(WatchlistState(newWatchList));
    }
  }

  void removeFromWatchList(
    int mediaId,
    String mediaType,
  ) async {
    Set newWatchList = Set.from(state.watchlist);
    newWatchList.remove(mediaId);
    emit(WatchlistState(newWatchList));
    final isRemoved = await removeFromWatchlistUsecase.call(mediaId, mediaType);
    if (isRemoved is Failures) {
      newWatchList.add(mediaId);
      emit(WatchlistState(newWatchList));
    }
  }
}
