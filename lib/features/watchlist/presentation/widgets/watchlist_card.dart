import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/constants/api_url.dart';
import '../../../../core/shared/entities/movie_entity.dart';
import '../../../../core/shared/entities/tv_entity.dart';
import '../../../home/presentation/home/bloc/watchlist/watchlist_cubit.dart';
import '../../../mediaPage/presentation/pages/media_details_page.dart';
import '../bloc/watchlist/watchlist_cubit.dart';

class WatchlistCard extends StatelessWidget {
  final int mediaId;
  final String mediaRating;
  final String mediaName;
  final String mediaOverview;
  final String mediaImgUrl;
  final String mediaType;
  final List watchlist;
  const WatchlistCard(
      {super.key,
      required this.mediaId,
      required this.mediaImgUrl,
      required this.mediaType,
      required this.watchlist,
      required this.mediaRating,
      required this.mediaName,
      required this.mediaOverview});

  @override
  Widget build(BuildContext context) {
    final WatchlistMediaCubit watchlistCubit =
        BlocProvider.of<WatchlistMediaCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: watchlistCubit,
                  child: MediaDetailsPage(
                      mediaId: mediaId,
                      mediaType: mediaType,
                      mediaName: mediaName,
                      mediaPoster: mediaImgUrl,
                      mediaOverview: mediaOverview,
                      mediaRate: mediaRating),
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    "${ApiUrl.movieImageBaseUrl}$mediaImgUrl"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16)),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: IconButton(
                    onPressed: () {
                      if (mediaType == "movie") {
                        BlocProvider.of<WatchlistCubit>(context)
                            .removeFromMovieWatchList(
                                mediaId, watchlist as List<Movie>);
                      } else {
                        BlocProvider.of<WatchlistCubit>(context)
                            .removeFromTvWatchList(
                                mediaId, watchlist as List<TV>);
                      }
                    },
                    icon: const Icon(
                      Icons.bookmark_remove_rounded,
                      color: Colors.red,
                    ))),
          ],
        ),
      ),
    );
  }
}
