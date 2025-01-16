import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_url.dart';
import '../../../../core/network/exeptions.dart';

import '../../../../core/shared/models/movie_model.dart';
import '../../../../core/shared/models/tranding_model.dart';
import '../../../../core/shared/models/tv_model.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../../../../core/shared/entities/tv_entity.dart';

abstract class ApiServices {
  Future<List<Tranding>> getTrandingMovies();
  Future<List<Movie>> getForYouMovies();
  Future<List<Movie>> getUpComingMovies();
  Future<List<Movie>> getTopRated();
  Future<List<TV>> getForYouTv();
  Future<Set> getWatchList();
  Future<Unit> addToWatchList(int mediaId, String mediaType);
  Future<Unit> removeFromWatchList(int mediaId, String mediaType);
}

class ApiServicesImpWithDio extends ApiServices {
  final Dio dio;

  ApiServicesImpWithDio({required this.dio});

  @override
  Future<List<Movie>> getForYouMovies() async {
    final response = await dio.get(ApiUrl.popularMovieUrl);

    if (response.statusCode == 200) {
      List jsonMovies = response.data["results"];
      final List<Movie> movies =
          jsonMovies.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Tranding>> getTrandingMovies() async {
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

  @override
  Future<List<TV>> getForYouTv() async {
    final response = await dio.get(ApiUrl.popularTvUrl);

    if (response.statusCode == 200) {
      List jsonTV = response.data["results"];
      final List<TV> movies = jsonTV.map((tv) => TVModel.fromJson(tv)).toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getUpComingMovies() async {
    final response = await dio.get(ApiUrl.upcommingMoviesUrl);

    if (response.statusCode == 200) {
      List jsonMovies = response.data["results"];
      final List<Movie> movies =
          jsonMovies.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addToWatchList(int mediaId, String mediaType) async {
    final response = await dio.post(ApiUrl.addToWatchlistUrl, data: {
      "media_type": mediaType,
      "media_id": mediaId,
      "watchlist": true
    });

    if (response.statusCode == 200) {
      if (response.data["success"]) {
        return unit;
      } else {
        throw AddException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> removeFromWatchList(int mediaId, String mediaType) async {
    final response = await dio.post(ApiUrl.addToWatchlistUrl, data: {
      "media_type": mediaType,
      "media_id": mediaId,
      "watchlist": false
    });

    if (response.statusCode == 200) {
      if (response.data["success"]) {
        return unit;
      } else {
        throw AddException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Set> getWatchList() async {
    final response = await dio.get(ApiUrl.watchListUrl);

    if (response.statusCode == 200) {
      List jsonWatchList = response.data["results"];
      return jsonWatchList.map((media) => media["id"]).toSet();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getTopRated() async {
    final response = await dio.get(ApiUrl.topRatedUrl);

    if (response.statusCode == 200) {
      List jsonMovies = response.data["results"];
      final List<Movie> movies =
          jsonMovies.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      throw ServerException();
    }
  }
}
