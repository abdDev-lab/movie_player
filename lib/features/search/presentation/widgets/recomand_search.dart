import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/constants/api_url.dart';
import '../bloc/cubit/page_mode_cubit.dart';
import '../bloc/recomandSearch/recomand_search_cubit.dart';
import '../bloc/searchCubit/search_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:uicons/uicons.dart';

class RecomandSearch extends StatelessWidget {
  const RecomandSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecomandSearchCubit, RecomandSearchState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return _costumLoading();
        } else if (state is LoadedRecomandSearchListState) {
          return Column(
            children: [
              Column(
                children: [
                  ...List.generate(
                    state.recomandMedia.length,
                    (index) => Container(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 45,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${ApiUrl.movieImageBaseUrl}${state.recomandMedia[index].posterPath}"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.recomandMedia[index].name}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${state.recomandMedia[index].voteAverage}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  ...List.generate(
                    state.keywords.length,
                    (index) => InkWell(
                      onTap: () {
                        BlocProvider.of<PageModeCubit>(context).borwseMode();
                        BlocProvider.of<SearchCubit>(context)
                            .getSearchedMedia(state.keywords[index]);
                        FocusScope.of(context).unfocus();
                        state.searchEditingController.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              UIcons.regularRounded.search,
                              color: const Color(0xFF606062),
                              size: 20,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: state.searchEditingController.text,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                              TextSpan(
                                  text: state.keywords[index].length > state.searchEditingController.text.length
                                      ? state.keywords[index].substring(state.searchEditingController.text.length)
                                      : '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white))
                            ]))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

Widget _costumLoading() {
  return Skeletonizer(
    enabled: true,
    child: Column(
      children: [
        Column(
          children: [
            ...List.generate(
              3,
              (index) => Container(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 45,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(AppImages.splashBackground),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Movie Name",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          children: [
            ...List.generate(
              3,
              (index) => Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      UIcons.regularRounded.search,
                      color: const Color(0xFF606062),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text("Movie Name ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.white))
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
