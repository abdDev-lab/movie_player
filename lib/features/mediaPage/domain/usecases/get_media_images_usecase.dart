import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../repostiory/media_details_repository.dart';

class GetMediaImagesUsecase {
  final MediaDetailsRepository mediaDetailsRepository;

  GetMediaImagesUsecase({required this.mediaDetailsRepository});
  Future<Either<Failures, List<String>>> call(
      int mediaId, String mediaType) async {
    return await mediaDetailsRepository.getMediaImages(mediaId, mediaType);
  }
}
