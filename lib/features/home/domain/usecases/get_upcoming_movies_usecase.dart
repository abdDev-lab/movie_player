import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../repositories/main_repository.dart';

class GetUpCommingMoviesUsecase {
  final MainRepository movieRepository;

  GetUpCommingMoviesUsecase({required this.movieRepository});

  Future<Either<Failures, List<Movie>>> call() async {
    return await movieRepository.getForUpComingMovies();
  }
}
