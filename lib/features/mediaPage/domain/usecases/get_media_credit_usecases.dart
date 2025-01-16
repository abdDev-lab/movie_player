import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../entities/media.dart';
import '../repostiory/media_details_repository.dart';

class GetMediaCreditUsecases {
  final MediaDetailsRepository mediaDetailsRepository;

  GetMediaCreditUsecases({required this.mediaDetailsRepository});
  Future<Either<Failures, List<Credit>>> call(int mediaId, String mediaType) async {
    return await mediaDetailsRepository.getMediaCredits(mediaId, mediaType);
  }
}
