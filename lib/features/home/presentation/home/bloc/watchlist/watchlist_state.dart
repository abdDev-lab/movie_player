part of 'watchlist_cubit.dart';

class WatchlistState extends Equatable {
  final Set watchlist;

  const WatchlistState(this.watchlist,);

  @override
  List<Object> get props => [watchlist];
}

