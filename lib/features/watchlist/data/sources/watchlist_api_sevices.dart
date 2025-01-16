import 'package:dio/dio.dart';
import '../../../../core/constants/api_url.dart';
import '../../../../core/network/exeptions.dart';
import '../../../../core/shared/models/movie_model.dart';
import '../../../../core/shared/models/tv_model.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../../../../core/shared/entities/tv_entity.dart';

abstract class WatchlistApiSevices {
  Future<List<Movie>> getWatchListMovie();
  Future<List<TV>> getWatchListTv();
}

class WatchlistApiSevicesWithDio extends WatchlistApiSevices {
  final Dio dio;

  WatchlistApiSevicesWithDio({required this.dio});

  @override
  Future<List<Movie>> getWatchListMovie() async {
    final response = await dio.get(ApiUrl.movieWatchListUrl);

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
  Future<List<TV>> getWatchListTv() async {
    final response = await dio.get(ApiUrl.tvWatchListUrl);

    if (response.statusCode == 200) {
      List jsonTV = response.data["results"];
      final List<TV> shows = jsonTV.map((tv) => TVModel.fromJson(tv)).toList();
      return shows;
    } else {
      throw ServerException();
    }
  }
}
