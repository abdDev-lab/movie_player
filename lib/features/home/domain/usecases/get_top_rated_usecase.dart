import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../repositories/main_repository.dart';


class GetTopRatedUsecase {
  final MainRepository mainRepository;

  GetTopRatedUsecase({required this.mainRepository});

  Future<Either<Failures, List<Movie>>> call() async {
    return await mainRepository.getTopRated();
  }
}
