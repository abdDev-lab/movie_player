class ApiUrl {
  static const String moviesAndTvBaseUrl = "https://api.themoviedb.org/3/";

  static const String allMoviesUrl =
      "discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc";

  static const String allTvsUrl =
      "discover/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=1&sort_by=popularity.desc";

  static const String popularMovieUrl = "movie/popular?language=en-US&page=1";
  static const String popularTvUrl = "tv/popular?language=en-US&page=1";

  static const String trendingMovieUrl = "trending/all/day?language=en-US";
  static const String upcommingMoviesUrl =
      "movie/upcoming?language=en-US&page=1";


  static const String topRatedUrl = "movie/top_rated?language=en-US&page=1";
  static const String movieImageBaseUrl = "https://image.tmdb.org/t/p/original";

  static const String addToWatchlistUrl =
      "account/21641741/watchlist?session_id=bccf435a0647960cdd4998bb21be135923d586dc";
  static const String watchListUrl =
      "account/21641741/watchlist/movies?language=en-US&page=1&sort_by=created_at.asc";
  static const String movieWatchListUrl =
      "account/21641741/watchlist/movies?language=en-US&page=1&sort_by=created_at.asc";
  static const String tvWatchListUrl =
      "account/21641741/watchlist/tv?language=en-US&page=1&sort_by=created_at.asc";

  static const String searchMediaUrl =
      "search/multi?include_adult=false&language=en-US&page=1";
  static const String keywordUrl = "search/keyword?page=1";

  static const String movieDetailsUrl = "movie/" ; //ID and for credit movie/id/credits same for videos
  static const String tvDetailsUrl = "tv/" ; //ID same like movies
  
  static const String videoBaseUrl = "https://www.youtube.com/watch?v=";
}
