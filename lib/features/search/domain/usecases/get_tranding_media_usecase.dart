import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../repository/search_repository.dart';

class GetTrandingMediaUsecase {
  final SearchRepository searchRepository;

  GetTrandingMediaUsecase({required this.searchRepository});

  Future<Either<Failures, List<Tranding>>> call() async {
    return await searchRepository.getTrandingMedia();
  }
}
