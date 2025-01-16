import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/configs/assets/app_images.dart';
import '../../../../../core/constants/api_url.dart';
import 'package:jiffy/jiffy.dart';
import '../bloc/upcommingMovies/upcomming_movies_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Coming Soon",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        BlocBuilder<UpcommingMoviesCubit, UpcommingMoviesState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return _costumLoading();
            } else if (state is LoadedUpCommingMoviesState) {
              return SizedBox(
                height: 180,
                child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                          width: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.bottomCenter,
                                  image: CachedNetworkImageProvider(
                                      "${ApiUrl.movieImageBaseUrl}${state.upCommingMovies[index].posterPath}"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(16)),
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 6, bottom: 6),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      colors: [
                                        Colors.black,
                                        Colors.black.withOpacity(0),
                                      ]),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Jiffy.parse(state.upCommingMovies[index]
                                            .releaseDate!)
                                        .MMMd,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Icon(Icons.notifications_none_rounded)
                                ],
                              )),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                    itemCount: state.upCommingMovies.length),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}

Widget _costumLoading() {
  return Skeletonizer(
    enabled: true,
    child: SizedBox(
      height: 180,
      child: ListView.separated(
          padding: const EdgeInsets.only(left: 16, right: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                width: 300,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage(AppImages.splashBackground),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(16)),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
          itemCount: 2),
    ),
  );
}
