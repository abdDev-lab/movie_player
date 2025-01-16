import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../home/presentation/home/bloc/watchlist/showBookMark/animated_bookmark_cubit.dart';
import '../bloc/media_details/media_details_cubit.dart';
import '../bloc/media_images/media_images_cubit.dart';
import '../bloc/media_trailers/media_trailers_cubit.dart';
import '../bloc/media_tranding/media_tranding_cubit.dart';
import '../bloc/top_casts/top_casts_cubit.dart';

import '../widgets/media_details_app_bar.dart';
import '../widgets/media_genres.dart';
import '../widgets/media_images.dart';
import '../widgets/media_top_casts.dart';
import '../widgets/media_trailer.dart';
import '../widgets/media_tranding.dart';
import '../../../../service_locator.dart';

class MediaDetailsPage extends StatelessWidget {
  final int mediaId;
  final String mediaType;
  final String mediaName;
  final String mediaPoster;
  final String mediaOverview;
  final String mediaRate;
  const MediaDetailsPage({
    super.key,
    required this.mediaId,
    required this.mediaType,
    required this.mediaName,
    required this.mediaPoster,
    required this.mediaOverview,
    required this.mediaRate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<MediaDetailsCubit>()..getMediaGenres(mediaId, mediaType),
        ),
        BlocProvider(
          create: (context) =>
              sl<TopCastsCubit>()..getMediaCasts(mediaId, mediaType),
        ),
        BlocProvider(
          create: (context) =>
              sl<MediaImagesCubit>()..getMediaImages(mediaId, mediaType),
        ),
        BlocProvider(
          create: (context) =>
              sl<MediaTrailersCubit>()..getMediaTrailer(mediaId, mediaType),
        ),
        BlocProvider(
          create: (context) => sl<MediaTrandingCubit>()..getMediaTranding(mediaId),
        ),
        BlocProvider(
          create: (context) => AnimatedBookmarkCubit(),
        ),
      ],
      child: CustomScrollView(
        slivers: [
          MediaDetailsAppBar(mediaId: mediaId, mediaPoster: mediaPoster),
          SliverList(
              delegate: SliverChildListDelegate([
            const MediaGenres(),
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mediaName,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          mediaOverview,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  const MediaTopCasts(),
                  MediaImages(mediaPoster: mediaPoster),
                  MediaTrailer(mediaPoster: mediaPoster)
                ],
              ),
            ),
            MediaTranding(mediaType: mediaType),
            const SizedBox(height: 24,)
          ])),
          
        ],
      ),
    ));
  }
}
