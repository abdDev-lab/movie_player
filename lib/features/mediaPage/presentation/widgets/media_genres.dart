import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_details/media_details_cubit.dart';

class MediaGenres extends StatelessWidget {
  const MediaGenres({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      margin: const EdgeInsets.only(bottom: 24, top: 24),
      alignment: Alignment.center,
      child: BlocBuilder<MediaDetailsCubit, MediaDetailsState>(
        builder: (context, state) {
          if (state is LoadedMediaGenresState) {
            return Wrap(
              alignment: WrapAlignment.center,
              children: [
                ...List.generate(
                  state.mediaGenres.genres!.length,
                  (index) => SizedBox(
                    // problem here
                    child: index != state.mediaGenres.genres!.length - 1
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${state.mediaGenres.genres![index].name}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                height: 4,
                                width: 4,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: const BoxDecoration(
                                    color: Colors.white70,
                                    shape: BoxShape.circle),
                              )
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${state.mediaGenres.genres![index].name}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
