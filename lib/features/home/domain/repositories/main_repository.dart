import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../../../../core/shared/entities/tv_entity.dart';

abstract class MainRepository {
  Future<Either<Failures, List<Movie>>> getForYouMovies();
  Future<Either<Failures, List<TV>>> getForYouTv();
  Future<Either<Failures, List<Tranding>>> getTranding();
  Future<Either<Failures, List<Movie>>> getForUpComingMovies();
  Future<Either<Failures, List<Movie>>> getTopRated();
  Future<Either<Failures, Set>> getWatchlist();
  Future<Either<Failures, Unit>> addToWatchlist(int mediaId, String mediaType);
  Future<Either<Failures, Unit>> removeFromWatchlist(
      int mediaId, String mediaType);
}
