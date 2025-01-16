import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../bloc/media_trailers/media_trailers_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaTrailer extends StatelessWidget {
  final String mediaPoster;
  const MediaTrailer({super.key, required this.mediaPoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        children: [
          const Text(
            "Trailer",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(
            height: 12,
          ),
          BlocBuilder<MediaTrailersCubit, MediaTrailersState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const SizedBox(
                  height: 230,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is LoadedMediaTrailers) {
                return Container(
                    width: 1000,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        YoutubePlayer(
                          controller: state.youtubePlayerController,
                          progressIndicatorColor: AppColors.primary,
                          progressColors: const ProgressBarColors(
                            handleColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ));
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
