import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../repostiory/media_details_repository.dart';

class GetMediaTraindingUsecase {
  final MediaDetailsRepository mediaDetailsRepository;

  GetMediaTraindingUsecase({required this.mediaDetailsRepository});
  Future<Either<Failures, List<Tranding>>> call(int mediaId) async {
    return await mediaDetailsRepository.getTranding(mediaId);
  }
}
