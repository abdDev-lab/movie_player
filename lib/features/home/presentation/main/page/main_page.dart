import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieplayer/features/home/presentation/home/bloc/forYou/foryou_cubit.dart';
import 'package:movieplayer/features/home/presentation/home/bloc/topRated/top_rated_cubit.dart';
import 'package:movieplayer/features/home/presentation/home/bloc/trandingMovies/tranding_movies_cubit.dart';
import 'package:movieplayer/features/home/presentation/home/bloc/upcommingMovies/upcomming_movies_cubit.dart';
import 'package:movieplayer/features/home/presentation/home/bloc/watchlist/watchlist_cubit.dart';
import '../bloc/mainBottomNavBar/main_bottom_nav_bar_cubit.dart';
import '../../home/pages/home_page.dart';
import '../../../../search/presentation/page/search_page.dart';

import '../../../../profile/presentation/page/settings_page.dart';
import '../widgets/home_bottom_nav_bar.dart';
import '../../../../watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import '../../../../watchlist/presentation/pages/watchlist_page.dart';
import '../../../../../service_locator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController mainPageController;

  @override
  void initState() {
    mainPageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainBottomNavBarCubit(),
        ),
        BlocProvider(
            create: (context) => sl<WatchlistMediaCubit>()..getWatchList()),
        BlocProvider(
          create: (context) => sl<TrandingCubit>()..getTrandingMovies(),
        ),
        BlocProvider(
          create: (context) => sl<ForyouCubit>()..getForYouMovies(),
        ),
        BlocProvider(
          create: (context) => sl<UpcommingMoviesCubit>()..getUpComingMovies(),
        ),
        BlocProvider(create: (context) => sl<TopRatedCubit>()..getTopRated()),
        BlocProvider(
          create: (context) => sl<WatchlistCubit>(),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: HomeBottomNavBar(
          pageController: mainPageController,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: mainPageController,
          children: const [
            HomePage(),
            WatchlistPage(),
            SearchPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}
