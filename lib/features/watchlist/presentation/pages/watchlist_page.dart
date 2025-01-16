import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/configs/theme/app_colors.dart';

import '../bloc/watchlist/select_movie_or_tv_cubit.dart';
import '../bloc/watchlist/watchlist_cubit.dart';
import '../widgets/watchlist_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WatchList",
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        BlocProvider(
          create: (context) => SelectMovieOrTvCubit(),
          child: BlocBuilder<SelectMovieOrTvCubit, Watchlist>(
            builder: (context, state) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<SelectMovieOrTvCubit>(context)
                          .selectMovie();

                      BlocProvider.of<WatchlistCubit>(context)
                          .getWatchlistMovies();
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 6, bottom: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: state == Watchlist.movie
                                ? AppColors.primary
                                : AppColors.background),
                        child: const AnimatedDefaultTextStyle(
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            duration: Duration(milliseconds: 150),
                            child: Text("Movies"))),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<SelectMovieOrTvCubit>(context).selectTv();

                      BlocProvider.of<WatchlistCubit>(context)
                          .getWatchlistShows();
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 6, bottom: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: state == Watchlist.shows
                                ? AppColors.primary
                                : AppColors.background),
                        child: const AnimatedDefaultTextStyle(
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            duration: Duration(milliseconds: 150),
                            child: Text("Shows"))),
                  )
                ],
              );
            },
          ),
        ),
        BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            List watchList = [];
            String mediaType = "movie";
            if (state is LoadingState) {
              return _costumLoading();
            } else if (state is LoadedWatchlistMoviesState) {
              watchList = state.watchlistMovies;
              mediaType = "movie";
            } else if (state is LoadedWatchlistTvState) {
              watchList = state.watchlistTv;
              mediaType = "tv";
            } else {
              return const SizedBox(); // loading
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.77,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: watchList.length,
                itemBuilder: (context, index) => WatchlistCard(
                      mediaId: watchList[index].id,
                      mediaImgUrl: watchList[index].posterPath,
                      mediaType: mediaType,
                      watchlist: watchList,
                      mediaRating: watchList[index]
                          .voteAverage
                          .toString()
                          .substring(0, 3),
                      mediaName: watchList[index].name,
                      mediaOverview: watchList[index].overview,
                    ));
          },
        ),
      ],
    );
  }
}

Widget _costumLoading() {
  return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.77,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(AppImages.splashBackground),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12)),
        ),
      ));
}
