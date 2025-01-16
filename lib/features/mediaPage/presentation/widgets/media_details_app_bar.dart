import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/constants/api_url.dart';
import '../../../home/presentation/home/bloc/watchlist/watchlist_cubit.dart';
import 'package:uicons/uicons.dart';

class MediaDetailsAppBar extends StatelessWidget {
  final int mediaId;
  final String mediaPoster;
  final bool isNetworkImage;

  const MediaDetailsAppBar(
      {super.key,
      required this.mediaId,
      required this.mediaPoster,
      this.isNetworkImage = true});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 80,
      pinned: true,
      surfaceTintColor: AppColors.background,
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(UIcons.regularStraight.angle_left)),
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          height: 524,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 24),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: isNetworkImage
                      ? CachedNetworkImageProvider(
                          "${ApiUrl.movieImageBaseUrl}$mediaPoster")
                      : AssetImage(mediaPoster),
                  fit: BoxFit.cover),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24))),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(32)),
                          child: const Row(
                            children: [
                              Text(
                                "Watch",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(CupertinoIcons.play_arrow_solid),
                            ],
                          )),
                    ),
                    Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle),
                        child: BlocBuilder<WatchlistMediaCubit, WatchlistState>(
                          builder: (context, state) {
                            return Icon(state.watchlist.contains(mediaId)
                                ? Icons.bookmark
                                : Icons.bookmark_border_rounded);
                          },
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
