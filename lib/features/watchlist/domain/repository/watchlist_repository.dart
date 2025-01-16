import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../../../../core/shared/entities/tv_entity.dart';

abstract class WatchlistRepository {
  Future<Either<Failures,List<Movie>>> getWatchListMovie();
  Future<Either<Failures,List<TV>>> getWatchListTv();

}