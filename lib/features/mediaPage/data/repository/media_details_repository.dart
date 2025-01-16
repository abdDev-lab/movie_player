import 'package:dartz/dartz.dart';
import '../../../../core/network/exeptions.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../sources/media_details_api_services.dart';
import '../../domain/entities/media.dart';
import '../../domain/repostiory/media_details_repository.dart';

class MediaDetailsRepositoryImp extends MediaDetailsRepository {
  final NetworkInfo networkInfo;
  final MediaDetailsApiServices mediaDetailsApiServices;

  MediaDetailsRepositoryImp(
      {required this.networkInfo, required this.mediaDetailsApiServices});
  @override
  Future<Either<Failures, MediaGenres>> getMediaGenres(
      int mediaId, String mediaType) async {
    if (await networkInfo.isConnected) {
      try {
        final mediaDetails =
            await mediaDetailsApiServices.getMediaGenres(mediaId, mediaType);
        return Right(mediaDetails);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<Credit>>> getMediaCredits(
      int mediaId, String mediaType) async {
    if (await networkInfo.isConnected) {
      try {
        final mediaCredit =
            await mediaDetailsApiServices.getMediaCredit(mediaId, mediaType);
        return Right(mediaCredit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Trailer>> getMediaTrailer(
      int mediaId, String mediaType) async {
    if (await networkInfo.isConnected) {
      try {
        final mediaTrailers =
            await mediaDetailsApiServices.getMediaTrailer(mediaId, mediaType);
        return Right(mediaTrailers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<String>>> getMediaImages(
      int mediaId, String mediaType) async {
    if (await networkInfo.isConnected) {
      try {
        final mediaImages =
            await mediaDetailsApiServices.getMediaImages(mediaId, mediaType);
        return Right(mediaImages);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<Tranding>>> getTranding(int mediaId) async {
    if (await networkInfo.isConnected) {
      try {
        final tranding = await mediaDetailsApiServices.getTranding(mediaId);
        return Right(tranding);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
