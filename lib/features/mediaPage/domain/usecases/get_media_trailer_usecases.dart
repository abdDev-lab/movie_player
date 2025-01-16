import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../entities/media.dart';
import '../repostiory/media_details_repository.dart';

class GetMediaTrailerUsecases {
  final MediaDetailsRepository mediaDetailsRepository;

  GetMediaTrailerUsecases({required this.mediaDetailsRepository});

  Future<Either<Failures, Trailer>> call(int mediaId, String mediaType) async {
    return await mediaDetailsRepository.getMediaTrailer(mediaId, mediaType);
  }
}
