import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/home/bloc/watchlist/showBookMark/animated_bookmark_cubit.dart';
import '../../features/home/presentation/home/bloc/watchlist/watchlist_cubit.dart';
import '../../features/home/presentation/home/widgets/animated_bookmark.dart';
import '../../features/mediaPage/presentation/pages/media_details_page.dart';
import '../constants/api_url.dart';

class MediaCard extends StatelessWidget {
  final int mediaId;
  final String mediaRating;
  final String mediaName;
  final String? mediaImageUrl;
  final String mediaType;
  final String mediaOverview;
  final bool showType;

  const MediaCard(
      {super.key,
      required this.mediaId,
      required this.mediaType,
      required this.mediaImageUrl,
      required this.mediaRating,
      required this.showType,
      required this.mediaOverview,
      required this.mediaName});

  @override
  Widget build(BuildContext context) {
    String mediaImage = "";
    bool isNetworkImage = true;
    if (mediaImageUrl != null) {
      mediaImage = mediaImageUrl!;
    } else {
      isNetworkImage = false;
      mediaImage = mediaType == "movie"
          ? "assets/images/movie_image.png"
          : "assets/images/movie_image.png";
    }

    return SizedBox(
      width: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                        value: context.read<WatchlistMediaCubit>(),
                        child: MediaDetailsPage(
                            isNetworkImage: isNetworkImage,
                            mediaId: mediaId,
                            mediaType: mediaType,
                            mediaName: mediaName,
                            mediaPoster: mediaImage,
                            mediaOverview: mediaOverview,
                            mediaRate: mediaRating),
                      )));
            },
            onDoubleTap: () {
              BlocProvider.of<WatchlistMediaCubit>(context)
                  .addToWatchList(mediaId, mediaType);
              BlocProvider.of<AnimatedBookmarkCubit>(context)
                  .addToWatchList(mediaId);
            },
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "${ApiUrl.movieImageBaseUrl}$mediaImageUrl"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(16)),
              child: Stack(
                children: [
                  Positioned(
                      top: 4,
                      left: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(mediaRating)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          showType
                              ? Container(
                                  padding: const EdgeInsets.only(
                                      left: 6, right: 6, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Icon(
                                    mediaType == "movie"
                                        ? Icons.movie_creation_rounded
                                        : Icons.tv_rounded,
                                    size: 22,
                                  ))
                              : const SizedBox()
                        ],
                      )),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: BlocBuilder<WatchlistMediaCubit, WatchlistState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              if (!state.watchlist.contains(mediaId)) {
                                BlocProvider.of<WatchlistMediaCubit>(context)
                                    .addToWatchList(mediaId, mediaType);
                                BlocProvider.of<AnimatedBookmarkCubit>(context)
                                    .addToWatchList(mediaId);
                              } else {
                                BlocProvider.of<WatchlistMediaCubit>(context)
                                    .removeFromWatchList(mediaId, mediaType);
                              }
                            },
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 1000),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16))),
                                child: Icon(state.watchlist.contains(mediaId)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_rounded)),
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
          BlocBuilder<AnimatedBookmarkCubit, AnimatedBookmarkState>(
            builder: (context, state) {
              if (state is StartAnimated && mediaId == state.mediaId) {
                return AnimatedBookmark(
                  animatedBookmarkCubit: context.read<AnimatedBookmarkCubit>(),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
