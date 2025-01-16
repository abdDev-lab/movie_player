import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/tv_entity.dart';
import '../repository/watchlist_repository.dart';

class GetWatchlistTvUsecase {
  final WatchlistRepository watchlistRepository;

  GetWatchlistTvUsecase({required this.watchlistRepository});
  Future<Either<Failures, List<TV>>> call() async {
    return await watchlistRepository.getWatchListTv();
  }
}
