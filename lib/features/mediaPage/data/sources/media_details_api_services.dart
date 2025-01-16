import 'package:dio/dio.dart';
import '../../../../core/constants/api_url.dart';
import '../../../../core/network/exeptions.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../../../../core/shared/models/tranding_model.dart';
import '../model/media_model.dart';
import '../../domain/entities/media.dart';

abstract class MediaDetailsApiServices {
  Future<MediaGenres> getMediaGenres(int mediaId, String mediaType);
  Future<Trailer> getMediaTrailer(int mediaId, String mediaType);
  Future<List<Credit>> getMediaCredit(int mediaId, String mediaType);
  Future<List<String>> getMediaImages(int mediaId, String mediaType);
  Future<List<Tranding>> getTranding(int mediaId);
}

class MediaDetailsApiServicesImpWithDio extends MediaDetailsApiServices {
  final Dio dio;

  MediaDetailsApiServicesImpWithDio({required this.dio});

  @override
  Future<MediaGenres> getMediaGenres(int mediaId, String mediaType) async {
    var response = await dio.get("/$mediaType/$mediaId");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMediaDetails = response.data;
      final media = MediaGenresModel.fromJson(jsonMediaDetails);
      return media;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Credit>> getMediaCredit(int mediaId, String mediaType) async {
    var response = await dio.get("/$mediaType/$mediaId/credits");
    if (response.statusCode == 200) {
      List jsonMediaCredit = response.data["cast"];
      final mediaCredit = jsonMediaCredit
          .map((element) => CreditModel.fromJson(element))
          .toList();
      return mediaCredit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Trailer> getMediaTrailer(int mediaId, String mediaType) async {
    var response = await dio.get("/$mediaType/$mediaId/videos");
    if (response.statusCode == 200) {
      List jsonMediaTrailers = response.data["results"];
      List filtredJsonMediaTrailer = jsonMediaTrailers
          .where((element) => element["type"] == "Trailer")
          .toList();
      final mediaTrailers = filtredJsonMediaTrailer
          .map((element) => TrailersModel.fromJson(element))
          .toList();
      return mediaTrailers[0];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getMediaImages(int mediaId, String mediaType) async {
    var response = await dio.get("/$mediaType/$mediaId/images");
    if (response.statusCode == 200) {
      List jsonMediaImages = response.data["backdrops"];
      final mediaImages = jsonMediaImages
          .map((element) => element["file_path"].toString())
          .toList();
      return mediaImages;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Tranding>> getTranding(int mediaId) async {
    final response = await dio.get(ApiUrl.trendingMovieUrl);
    if (response.statusCode == 200) {
      List jsonMovies = response.data["results"];
      final List<TrandingModel> filterTranding =
          jsonMovies.map((movie) => TrandingModel.fromJson(movie)).toList();
        final List<Tranding> tranding = filterTranding
          .where((element) => element.id != mediaId)
          .toList();
      return tranding;
    } else {
      throw ServerException();
    }
  }
}
