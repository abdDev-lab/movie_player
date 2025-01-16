import 'package:dartz/dartz.dart';
import '../../../../core/network/exeptions.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../../../../core/shared/entities/tv_entity.dart';
import '../sources/watchlist_api_sevices.dart';
import '../../domain/repository/watchlist_repository.dart';

class WatchlistRepostioryImp extends WatchlistRepository {
  final NetworkInfo networkInfo;
  final WatchlistApiSevices watchlistApiSevices;

  WatchlistRepostioryImp(
      {required this.networkInfo, required this.watchlistApiSevices});
  @override
  Future<Either<Failures, List<Movie>>> getWatchListMovie() async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await watchlistApiSevices.getWatchListMovie();
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<TV>>> getWatchListTv() async {
    if (await networkInfo.isConnected) {
      try {
        final shows = await watchlistApiSevices.getWatchListTv();
        return Right(shows);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
