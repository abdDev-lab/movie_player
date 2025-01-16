import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/widgets/media_card.dart';
import '../bloc/media_tranding/media_tranding_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MediaTranding extends StatelessWidget {
  final String mediaType ;
  const MediaTranding({super.key, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            "You will like it",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        const SizedBox(height: 12,),
        BlocBuilder<MediaTrandingCubit, MediaTrandingState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return _costumLoading();
            } else if (state is LoadedMediaTrandingState) {
              return SizedBox(
                height: 220,
                child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => MediaCard(
                          showType: false,
                          mediaId: state.mediaTranding[index].id!,
                          mediaName: state.mediaTranding[index].title!,
                          mediaOverview: state.mediaTranding[index].overview!,
                          mediaType: mediaType,
                          mediaImageUrl: state.mediaTranding[index].posterPath!,
                          mediaRating: state.mediaTranding[index].voteAverage
                              .toString()
                              .substring(0, 3),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                    itemCount: state.mediaTranding.length),
              );
            } else {
              return const SizedBox();
            }
          },
        )
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

