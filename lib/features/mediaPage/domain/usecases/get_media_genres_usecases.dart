import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../entities/media.dart';
import '../repostiory/media_details_repository.dart';

class GetMediaGenresUsecases {
  final MediaDetailsRepository mediaDetailsRepository;

  GetMediaGenresUsecases({required this.mediaDetailsRepository});
  Future<Either<Failures, MediaGenres>> call(
      int mediaId, String mediaType) async {
    return await mediaDetailsRepository.getMediaGenres(mediaId, mediaType);
  }
}
