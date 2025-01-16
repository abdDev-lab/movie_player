import 'package:dio/dio.dart';
import '../../../../core/constants/api_url.dart';
import '../../../../core/network/exeptions.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../../../../core/shared/models/tranding_model.dart';
import '../model/search_model.dart';
import '../../domain/entity/search_entitiy.dart';

abstract class SearchApiService {
  Future<List<SearchEntity>> getSearchedMedia(String searchInput);
  Future<List<SearchEntity>> getRecomandMedia(String searchInput);
  Future<List<String>> getSearchKeyWord(String searchInput);
  Future<List<Tranding>> getTrandingMedia();
}

class SearchApiServiceImpWithDio extends SearchApiService {
  final Dio dio;

  SearchApiServiceImpWithDio({required this.dio});

  @override
  Future<List<SearchEntity>> getSearchedMedia(String searchInput) async {
    final response =
        await dio.get("${ApiUrl.searchMediaUrl}&query=$searchInput");
    if (response.statusCode == 200) {
      List jsonSearch = response.data["results"];
      final List<SearchEntity> searchList =
          jsonSearch.map((media) => SearchModel.fromJson(media)).toList();
      return searchList.where((element) => element.mediaType != "person").toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SearchEntity>> getRecomandMedia(String searchInput) async {
    final response =
        await dio.get("${ApiUrl.searchMediaUrl}&query=$searchInput");
    if (response.statusCode == 200) {
      List jsonSearch = response.data["results"];
      final List<SearchEntity> searchList = jsonSearch
          .map((media) => SearchModel.fromJson(media))
          .where((element) => element.mediaType != "person")
          .toList();
      return searchList.take(3).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getSearchKeyWord(String searchInput) async {
    final response = await dio.get("${ApiUrl.keywordUrl}&query=$searchInput");
    if (response.statusCode == 200) {
      List jsonSearch = response.data["results"];
      final List<String> keywords =
          jsonSearch.map((keyword) => keyword["name"].toString()).toList();
      return keywords
          .where((element) => element.toLowerCase().startsWith(searchInput))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Tranding>> getTrandingMedia() async {
    final response = await dio.get(ApiUrl.trendingMovieUrl);
    if (response.statusCode == 200) {
      List jsonMovies = response.data["results"];
      final List<TrandingModel> tranding =
          jsonMovies.map((movie) => TrandingModel.fromJson(movie)).toList();
      return tranding;
    } else {
      throw ServerException();
    }
  }
}
