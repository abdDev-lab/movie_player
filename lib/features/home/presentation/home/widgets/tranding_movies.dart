import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/configs/assets/app_images.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../core/constants/api_url.dart';
import '../bloc/trandingMovies/tranding_movies_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrandingMovies extends StatefulWidget {
  const TrandingMovies({super.key});

  @override
  State<TrandingMovies> createState() => _TrandingMoviesState();
}

class _TrandingMoviesState extends State<TrandingMovies> {
  late PageController _trandingMoviesController;

  @override
  void initState() {
    _trandingMoviesController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<TrandingCubit>(context).autoScrollingTrandingMovies();
    return BlocBuilder<TrandingCubit, TrandingState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return _costumLoading(context);
        } else if (state is LoadedTrandingState) {
          if (_trandingMoviesController.hasClients) {
            if (state.pageIndex == 0) {
              _trandingMoviesController.jumpToPage(0);
            }
            _trandingMoviesController.animateToPage(state.pageIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          }
          return Stack(
            children: [
              SizedBox(
                height: 560,
                child: PageView.builder(
                  controller: _trandingMoviesController,
                  onPageChanged: (value) {
                    BlocProvider.of<TrandingCubit>(context)
                        .scrollingTrandingMovies(value);
                  },
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "${ApiUrl.movieImageBaseUrl}${state.tranding[index].posterPath}"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  itemCount: 7,
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                      AppColors.secondBackground,
                      AppColors.secondBackground.withOpacity(0),
                      AppColors.secondBackground.withOpacity(0.8),
                      AppColors.secondBackground,
                    ]))),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${state.tranding[state.pageIndex].title}",
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 12, right: 16, left: 16),
                          ),
                          child: const Text(
                            "Watch Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Tranding",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            7,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 10,
                              width: 10,
                              margin: EdgeInsets.only(
                                  right: index + 1 != 7 ? 4 : 0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index == state.pageIndex
                                      ? AppColors.primary
                                      : Colors.white.withOpacity(0.1)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

Widget _costumLoading(BuildContext context) {
  return Skeletonizer(
    enabled: true,

    child: Stack(
      children: [
        SizedBox(
          height: 560,
          child: Card(
            child: Image.asset(
              AppImages.splashBackground,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                AppColors.secondBackground,
                AppColors.secondBackground.withOpacity(0),
                AppColors.secondBackground.withOpacity(0.8),
                AppColors.secondBackground,
              ]))),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Movie Title",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, right: 16, left: 16),
                    ),
                    child: const Text(
                      "Watch Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Tranding",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
