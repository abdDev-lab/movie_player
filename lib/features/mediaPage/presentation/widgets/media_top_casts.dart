import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/constants/api_url.dart';
import '../bloc/top_casts/top_casts_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MediaTopCasts extends StatelessWidget {
  const MediaTopCasts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              "Top Casts",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<TopCastsCubit, TopCastsState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return _costumLoading();
              } else if (state is LoadedMediaCasts) {
                return SizedBox(
                  height: 120,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 32,
                    ),
                    itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(

                                // alignment: Alignment.topCenter,
                                image: CachedNetworkImageProvider(
                                    "${ApiUrl.movieImageBaseUrl}${state.mediaCredit[index].profilePath}"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${state.mediaCredit[index].name}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${state.mediaCredit[index].role}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500]),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}

Widget _costumLoading() {
  return Skeletonizer(
    enabled: true,
    child: SizedBox(
      height: 120,
      child: ListView.separated(
          padding: const EdgeInsets.only(left: 16, right: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AppImages.splashBackground),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Actor Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Role name",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500]),
                  )
                ],
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 32,
              ),
          itemCount: 3),
    ),
  );
}
