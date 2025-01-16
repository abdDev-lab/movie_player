import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../repository/watchlist_repository.dart';

class GetWatchlistMovieUsecase {
  final WatchlistRepository watchlistRepository;

  GetWatchlistMovieUsecase({required this.watchlistRepository});

  Future<Either<Failures, List<Movie>>> call() async {
    return await watchlistRepository.getWatchListMovie();
  }
}
