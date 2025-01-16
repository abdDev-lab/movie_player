import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../entity/search_entitiy.dart';

abstract class SearchRepository {
  Future<Either<Failures, List<SearchEntity>>> getSearchedMedia(
      String searchInput);
  Future<Either<Failures, List<Tranding>>> getTrandingMedia();
  Future<Either<Failures, Map>> getRecomandSearch(String searchInput);
}
