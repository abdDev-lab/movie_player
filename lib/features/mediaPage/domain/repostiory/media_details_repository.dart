import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../entities/media.dart';

abstract class MediaDetailsRepository {
  Future<Either<Failures, MediaGenres>> getMediaGenres(int mediaId , String mediaType);
  Future<Either<Failures, List<Credit>>> getMediaCredits(int mediaId , String mediaType);
  Future<Either<Failures, Trailer>> getMediaTrailer(int mediaId , String mediaType);
  Future<Either<Failures, List<String>>> getMediaImages(int mediaId , String mediaType);
  Future<Either<Failures, List<Tranding>>> getTranding(int mediaId);


}
