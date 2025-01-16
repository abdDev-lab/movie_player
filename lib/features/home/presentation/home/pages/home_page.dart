import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieplayer/core/configs/assets/app_images.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../bloc/menuAppBar/menu_app_bar_cubit.dart';
import '../widgets/coming_soon.dart';
import '../widgets/foryou.dart';
import '../widgets/home_menu_app_bar.dart';
import '../widgets/top_rated.dart';

import '../widgets/tranding_movies.dart';

import '../../../../../service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<MenuAppBarCubit>()),
         
        ],
        child: Scaffold(
          backgroundColor: AppColors.secondBackground,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                  titleSpacing: 0,
                  title: Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: Image.asset(
                                AppImages.logoImage,
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const HomeMenuAppBar(),
                      ],
                    ),
                  ),
                  surfaceTintColor: AppColors.background,
                  pinned: true,
                  toolbarHeight: 98,
                  expandedHeight: 524,
                  flexibleSpace: const FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: TrandingMovies(),
                  )),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 16,
                ),
                const ForYou(),
                const SizedBox(
                  height: 16,
                ),
                const TopRated(),
                const SizedBox(
                  height: 16,
                ),
                const ComingSoon(),
              ]))
            ],
          ),
        ));
  }
}
