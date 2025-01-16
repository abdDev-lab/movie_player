import 'package:dartz/dartz.dart';
import '../../../../core/network/exeptions.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../sources/search_api_service.dart';
import '../../domain/entity/search_entitiy.dart';
import '../../domain/repository/search_repository.dart';

class SearchRepositoryImp extends SearchRepository {
  final NetworkInfo networkInfo;
  final SearchApiService searchApiService;

  SearchRepositoryImp(
      {required this.networkInfo, required this.searchApiService});

  @override
  Future<Either<Failures, List<SearchEntity>>> getSearchedMedia(
      String searchInput) async {
    if (await networkInfo.isConnected) {
      try {
        final media = await searchApiService.getSearchedMedia(searchInput);
        return Right(media);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Map>> getRecomandSearch(String searchInput) async {
    Map recomandMedia = {};
    if (await networkInfo.isConnected) {
      try {
        final media = await searchApiService.getRecomandMedia(searchInput);
        final keyword = await searchApiService.getSearchKeyWord(searchInput);
        recomandMedia["media"] = media;
        recomandMedia["keyword"] = keyword;
        return Right(recomandMedia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, List<Tranding>>> getTrandingMedia() async {
    if (await networkInfo.isConnected) {
      try {
        final media = await searchApiService.getTrandingMedia();
        return Right(media);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
