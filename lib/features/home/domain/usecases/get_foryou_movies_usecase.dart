import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../repositories/main_repository.dart';


class GetForyouMoviesUsecase {
  final MainRepository movieRepository;

  GetForyouMoviesUsecase({required this.movieRepository});

  Future<Either<Failures, List<Movie>>> call() async {
    return await movieRepository.getForYouMovies();
  }
}
