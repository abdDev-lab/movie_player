import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/configs/assets/app_images.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../../../../core/widgets/media_card.dart';
import '../bloc/forYou/foryou_cubit.dart';
import '../bloc/forYou/selectable_foryou_option_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ForYou extends StatelessWidget {
  const ForYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "For You",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        BlocProvider(
          create: (context) => SelectableForyouOptionCubit(),
          child: BlocBuilder<SelectableForyouOptionCubit, ForyouType>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        BlocProvider.of<SelectableForyouOptionCubit>(context)
                            .selectMovie();

                        BlocProvider.of<ForyouCubit>(context).getForYouMovies();
                      },
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 6, bottom: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: state == ForyouType.movie
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
                        BlocProvider.of<SelectableForyouOptionCubit>(context)
                            .selectTv();

                        BlocProvider.of<ForyouCubit>(context).getForYouShows();
                      },
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 6, bottom: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: state == ForyouType.shows
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
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        BlocBuilder<ForyouCubit, ForyouState>(
          builder: (context, state) {
            List foryou = [];
            String mediaType = "movie";
            if (state is LoadingState) {
              return _costumLoading();
            } else if (state is LoadedForyouMoviesState) {
              foryou = state.foryouMovies;
              mediaType = "movie";
            } else if (state is LoadedForyouTvState) {
              foryou = state.foryouTv;
              mediaType = "tv";
            }

            return SizedBox(
              height: 220,
              child: ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => MediaCard(
                      showType: false,
                      mediaId: foryou[index].id,
                      mediaName: foryou[index].name,
                      mediaOverview: foryou[index].overview,
                      mediaRating:
                          foryou[index].voteAverage.toString().substring(0, 3),
                      mediaType: mediaType,
                      mediaImageUrl: foryou[index].posterPath),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 16,
                      ),
                  itemCount: foryou.length),
            );
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
        height: 220,
        child: ListView.separated(
            padding: const EdgeInsets.only(left: 16, right: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
                  width: 170,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(AppImages.splashBackground),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12)),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  width: 16,
                ),
            itemCount: 2),
      ));
}
