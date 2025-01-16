import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/constants/api_url.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/data/sources/auth_api_service.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/auth/bloc/login/login_bloc.dart';
import 'features/auth/presentation/splash/cubit/splash_cubit.dart';
import 'features/home/data/repositories/movie_repostiory.dart';

import 'features/home/data/sources/api_services.dart';
import 'features/home/domain/repositories/main_repository.dart';
import 'features/home/domain/usecases/add_to_watchlist_usecase.dart';
import 'features/home/domain/usecases/get_foryou_movies_usecase.dart';
import 'features/home/domain/usecases/get_foryou_tv_usecase.dart';
import 'features/home/domain/usecases/get_top_rated_usecase.dart';

import 'features/home/domain/usecases/get_tranding_usecase.dart';
import 'features/home/domain/usecases/get_upcoming_movies_usecase.dart';
import 'features/home/domain/usecases/get_watchlist_usecase.dart';
import 'features/home/domain/usecases/remove_from_watchlist_usecase.dart';
import 'features/home/presentation/home/bloc/forYou/foryou_cubit.dart';
import 'features/home/presentation/home/bloc/menuAppBar/menu_app_bar_cubit.dart';
import 'features/home/presentation/home/bloc/topRated/top_rated_cubit.dart';
import 'features/home/presentation/home/bloc/trandingMovies/tranding_movies_cubit.dart';
import 'features/home/presentation/home/bloc/upcommingMovies/upcomming_movies_cubit.dart';
import 'features/home/presentation/home/bloc/watchlist/watchlist_cubit.dart';
import 'features/mediaPage/data/repository/media_details_repository.dart';
import 'features/mediaPage/data/sources/media_details_api_services.dart';
import 'features/mediaPage/domain/repostiory/media_details_repository.dart';
import 'features/mediaPage/domain/usecases/get_media_credit_usecases.dart';
import 'features/mediaPage/domain/usecases/get_media_genres_usecases.dart';
import 'features/mediaPage/domain/usecases/get_media_images_usecase.dart';
import 'features/mediaPage/domain/usecases/get_media_trailer_usecases.dart';
import 'features/mediaPage/domain/usecases/get_media_trainding_usecase.dart';
import 'features/mediaPage/presentation/bloc/media_details/media_details_cubit.dart';
import 'features/mediaPage/presentation/bloc/media_images/media_images_cubit.dart';
import 'features/mediaPage/presentation/bloc/media_trailers/media_trailers_cubit.dart';
import 'features/mediaPage/presentation/bloc/media_tranding/media_tranding_cubit.dart';
import 'features/mediaPage/presentation/bloc/top_casts/top_casts_cubit.dart';
import 'features/search/data/repository/search_repository.dart';
import 'features/search/data/sources/search_api_service.dart';
import 'features/search/domain/repository/search_repository.dart';
import 'features/search/domain/usecases/get_recomand_search_usecase.dart';
import 'features/search/domain/usecases/get_searched_media_usecase.dart';
import 'features/search/domain/usecases/get_tranding_media_usecase.dart';
import 'features/search/presentation/bloc/recomandSearch/recomand_search_cubit.dart';
import 'features/search/presentation/bloc/searchCubit/search_cubit.dart';
import 'features/watchlist/data/repository/watchlist_repostiory.dart';
import 'features/watchlist/data/sources/watchlist_api_sevices.dart';
import 'features/watchlist/domain/repository/watchlist_repository.dart';
import 'features/watchlist/domain/usecase/get_watchlist_movie_usecase.dart';
import 'features/watchlist/domain/usecase/get_watchlist_tv_usecase.dart';
import 'features/watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Dio
  final sharedPreferences = await SharedPreferences.getInstance();



  BaseOptions movieAndTvOptions = BaseOptions(
    baseUrl: ApiUrl.moviesAndTvBaseUrl,
    headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NmQ4NWNkZWEyNjVlODM5MzBkMGJiOWZjN2ViZTJmZSIsIm5iZiI6MTczMjI5MDY3NC42NzcwNTc1LCJzdWIiOiI2NzNkZDQzMjdiN2M0YTQ5NTUzMzYwNTkiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.y6mJ6Rwj6q8Q0JgnJKHVtJqogv2a6DmhmlohdkAc5F4"
    },
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );

  //! Features => Auth

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerFactory(() => SplashCubit(sharedPreferences));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  sl.registerLazySingleton<AuthApiService>(
      () => AuthApiServiceImpWithDio());

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(authApiService: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  sl.registerFactory(() => LoginBloc(sl(), sl()));

  //! Features => Home

  sl.registerLazySingleton<ApiServices>(
      () => ApiServicesImpWithDio(dio: Dio(movieAndTvOptions)));

  sl.registerLazySingleton<MainRepository>(
      () => MainRepostioryImp(apiServices: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetTrandingUsecase(trandingRepository: sl()));
  sl.registerLazySingleton(() => GetForyouMoviesUsecase(movieRepository: sl()));
  sl.registerLazySingleton(
      () => GetUpCommingMoviesUsecase(movieRepository: sl()));
  sl.registerLazySingleton(() => GetForyouTvUsecase(showsRepository: sl()));

  sl.registerLazySingleton(() => GetWatchListUsecase(mainRepository: sl()));
  sl.registerLazySingleton(() => AddToWatchlistUsecase(mainRepository: sl()));
  sl.registerLazySingleton(
      () => RemoveFromWatchlistUsecase(mainRepository: sl()));
  sl.registerLazySingleton(() => GetTopRatedUsecase(mainRepository: sl()));

  // Bloc
  sl.registerFactory(() => MenuAppBarCubit());
  sl.registerFactory(() => TrandingCubit(sl()));
  sl.registerFactory(() => ForyouCubit(sl(), sl()));
  sl.registerFactory(() => UpcommingMoviesCubit(sl()));
  sl.registerFactory(() => WatchlistMediaCubit(sl(), sl(), sl()));
  sl.registerFactory(() => TopRatedCubit(sl()));

  //! Features => Watchlist
  sl.registerLazySingleton<WatchlistApiSevices>(
      () => WatchlistApiSevicesWithDio(dio: Dio(movieAndTvOptions)));
  sl.registerLazySingleton<WatchlistRepository>(() =>
      WatchlistRepostioryImp(watchlistApiSevices: sl(), networkInfo: sl()));
  // UseCases
  sl.registerLazySingleton(
      () => GetWatchlistMovieUsecase(watchlistRepository: sl()));
  sl.registerLazySingleton(
      () => GetWatchlistTvUsecase(watchlistRepository: sl()));

  sl.registerFactory(() => WatchlistCubit(sl(), sl(), sl()));

  // Data Sources

  //! Features => Search
  sl.registerLazySingleton<SearchApiService>(
      () => SearchApiServiceImpWithDio(dio: Dio(movieAndTvOptions)));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImp(searchApiService: sl(), networkInfo: sl()));
  // UseCases
  sl.registerLazySingleton(
      () => GetSearchedMediaUseCase(searchRepository: sl()));
  sl.registerLazySingleton(
      () => GetRecomandSearchUsecase(searchRepository: sl()));
  sl.registerLazySingleton(
      () => GetTrandingMediaUsecase(searchRepository: sl()));
  sl.registerFactory(() => SearchCubit(sl(), sl()));
  sl.registerFactory(() => RecomandSearchCubit(
        sl(),
      ));

  //! MediaDetails
  sl.registerLazySingleton<MediaDetailsApiServices>(
      () => MediaDetailsApiServicesImpWithDio(dio: Dio(movieAndTvOptions)));
  sl.registerLazySingleton<MediaDetailsRepository>(() =>
      MediaDetailsRepositoryImp(
          mediaDetailsApiServices: sl(), networkInfo: sl()));
  // UseCases
  sl.registerLazySingleton(
      () => GetMediaGenresUsecases(mediaDetailsRepository: sl()));
  sl.registerLazySingleton(
      () => GetMediaCreditUsecases(mediaDetailsRepository: sl()));
  sl.registerLazySingleton(
      () => GetMediaImagesUsecase(mediaDetailsRepository: sl()));
  sl.registerLazySingleton(
      () => GetMediaTrailerUsecases(mediaDetailsRepository: sl()));
  sl.registerLazySingleton(
      () => GetMediaTraindingUsecase(mediaDetailsRepository: sl()));
  sl.registerFactory(() => MediaDetailsCubit(sl()));
  sl.registerFactory(() => TopCastsCubit(sl()));
  sl.registerFactory(() => MediaImagesCubit(sl()));
  sl.registerFactory(() => MediaTrailersCubit(sl()));
  sl.registerFactory(() => MediaTrandingCubit(sl()));

  //! Externel
}
// void setupServiceLocator()  {
//      BaseOptions options = BaseOptions(
//     baseUrl: ApiUrl.baseUrl,
//     connectTimeout: const Duration(seconds: 15),
//     receiveTimeout: const Duration(seconds: 15),
//   );
//   print('Registering Dio...');
//   sl.registerLazySingleton(() => Dio(options));
//   print('Registering InternetConnectionChecker...');
//   sl.registerLazySingleton(() => InternetConnectionChecker());
//   print('Registering NetworkInfo...');
//   sl.registerLazySingleton<NetworkInfo>(
//     () => NetworkInfoImpl(internetConnectionChecker: sl()),
//   );
//   print('Registering AuthApiService...');
//   sl.registerLazySingleton<AuthApiService>(
//     () => AuthApiServiceImpWithDio(dio: sl()),
//   );
//   print('Registering AuthRepository...');
//   sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(
//     authApiServiceImpWithDio: sl(),
//     networkInfoImpl: sl(),
//   ));
//   print('Registering LoginUsecase...');
//   sl.registerLazySingleton(() => LoginUsecase(sl()));
//   print('Registering AuthCubit...');
//   sl.registerFactory<AuthCubit>(() => AuthCubit(loginUsecase: sl()));
//   print('Service Locator setup completed.');
// }
