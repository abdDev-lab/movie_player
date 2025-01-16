import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/constants/api_url.dart';
import '../bloc/media_images/media_images_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MediaImages extends StatelessWidget {
  final String mediaPoster;
  const MediaImages({super.key, required this.mediaPoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 24),
      height: 200,
      child: BlocBuilder<MediaImagesCubit, MediaImagesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return _costumLoading();
          } else if (state is LoadedMediaImages) {
            return ListView.separated(
              padding: const EdgeInsets.only(left: 24, right: 24),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.mediaImages.length,
              separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
              itemBuilder: (context, index) => Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "${ApiUrl.movieImageBaseUrl}${state.mediaImages[index]}"),
                      fit: BoxFit.cover),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

Widget _costumLoading() {
  return Skeletonizer(
    enabled: true,
    child: SizedBox(
      height: 200,
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
          itemCount: 1),
    ),
  );
}
