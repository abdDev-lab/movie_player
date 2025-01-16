import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/tv_entity.dart';
import '../repositories/main_repository.dart';

class GetForyouTvUsecase {
  final MainRepository showsRepository;

  GetForyouTvUsecase({required this.showsRepository});

  Future<Either<Failures, List<TV>>> call() async {
    return await showsRepository.getForYouTv();
  }
}
