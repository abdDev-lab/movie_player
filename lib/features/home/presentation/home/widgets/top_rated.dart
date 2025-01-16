import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/configs/assets/app_images.dart';
import '../../../../../core/widgets/media_card.dart';
import '../bloc/topRated/top_rated_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Top Rated",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        BlocBuilder<TopRatedCubit, TopRatedState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return _costumLoading();
            } else if (state is LoadedTopRatedState) {
              return SizedBox(
                height: 220,
                child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => MediaCard(
                          showType: false,
                          mediaId: state.topRated[index].id!,
                          mediaName: state.topRated[index].name!,
                          mediaOverview: state.topRated[index].overview!,
                          mediaType: "movie",
                          mediaImageUrl: state.topRated[index].posterPath!,
                          mediaRating: state.topRated[index].voteAverage
                              .toString()
                              .substring(0, 3),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                    itemCount: state.topRated.length),
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
