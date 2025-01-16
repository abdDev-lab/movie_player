import 'package:dartz/dartz.dart';
import '../../../../core/network/exeptions.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/network/network_info.dart';
import '../sources/api_services.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../../../../core/shared/entities/tv_entity.dart';
import '../../domain/repositories/main_repository.dart';

class MainRepostioryImp extends MainRepository {
  final NetworkInfo networkInfo;
  final ApiServices apiServices;

  MainRepostioryImp({required this.networkInfo, required this.apiServices});

  @override
  Future<Either<Failures, List<Movie>>> getForYouMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await apiServices.getForYouMovies();
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<Tranding>>> getTranding() async {
    if (await networkInfo.isConnected) {
      try {
        final tranding = await apiServices.getTrandingMovies();
        return Right(tranding);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<TV>>> getForYouTv() async {
    if (await networkInfo.isConnected) {
      try {
        final shows = await apiServices.getForYouTv();
        return Right(shows);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<Movie>>> getForUpComingMovies() async {
    if (await networkInfo.isConnected) {
      try {
        List<Movie> movies = await apiServices.getUpComingMovies();
        List<Movie> filterMovies = movies
            .where((movie) =>
                DateTime.parse(movie.releaseDate!)
                    .difference(DateTime.now())
                    .inDays >
                0)
            .toList();
        return Right(filterMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> addToWatchlist(
      int mediaId, String mediaType) async {
    if (await networkInfo.isConnected) {
      try {
        await apiServices.addToWatchList(mediaId, mediaType);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on AddException {
        return Left(AddFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> removeFromWatchlist(
      int mediaId, String mediaType) async {
    if (await networkInfo.isConnected) {
      try {
        await apiServices.removeFromWatchList(mediaId, mediaType);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on AddException {
        return Left(AddFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Set>> getWatchlist() async {
    if (await networkInfo.isConnected) {
      try {
        final watchList = await apiServices.getWatchList();
        return Right(watchList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<Movie>>> getTopRated() async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await apiServices.getTopRated();
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
