import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/widgets/media_card.dart';
import '../bloc/searchCubit/search_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:uicons/uicons.dart';

class SearchOutput extends StatelessWidget {
  const SearchOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return _costumLoading();
        } else if (state is LoadedTrandingMediaState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Trending",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.77,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.media.length,
                  itemBuilder: (context, index) => MediaCard(
                        showType: true,
                        mediaName: state.media[index].title!,
                        mediaOverview: state.media[index].overview!,
                        mediaId: state.media[index].id!,
                        mediaType: state.media[index].mediaType!,
                        mediaImageUrl: state.media[index].posterPath!,
                        mediaRating: state.media[index].voteAverage
                            .toString()
                            .substring(0, 3),
                      )),
            ],
          );
        } else if (state is LoadedSearchListState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search for '${state.searchInput}'",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        BlocProvider.of<SearchCubit>(context)
                            .getTrandingMedia();
                      },
                      icon: Icon(UIcons.regularRounded.cross_circle))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.77,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.searchList.length,
                  itemBuilder: (context, index) => MediaCard(
                        showType: false,
                        mediaName: state.searchList[index].name!,
                        mediaOverview: state.searchList[index].overview!,
                        mediaId: state.searchList[index].id!,
                        mediaType: state.searchList[index].mediaType!,
                        mediaImageUrl: state.searchList[index].posterPath,
                        mediaRating: state.searchList[index].voteAverage
                            .toString()
                            .substring(0, 3),
                      )),
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
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.77,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(AppImages.splashBackground),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12)),
        ),
      ));
}
