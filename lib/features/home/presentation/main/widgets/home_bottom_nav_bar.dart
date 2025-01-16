import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieplayer/features/home/presentation/home/bloc/watchlist/watchlist_cubit.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../bloc/mainBottomNavBar/main_bottom_nav_bar_cubit.dart';
import '../../../../watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:uicons/uicons.dart';

class HomeBottomNavBar extends StatelessWidget {
  final PageController pageController;
  const HomeBottomNavBar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    List<Map> menuItems = [
      {
        "title": "Home",
        "Icon": UIcons.regularRounded.home,
        "onTap": () {
          print("hellow");
          BlocProvider.of<WatchlistMediaCubit>(context).getWatchList();
        }
      },
      {
        "title": "Watchlist",
        "Icon": UIcons.regularRounded.bookmark,
        "onTap": () {}
      },
      {"title": "Search", "Icon": UIcons.regularRounded.search, "onTap": () {}},
      {"title": "Profile", "Icon": UIcons.regularRounded.user, "onTap": () {}},
    ];
    return BlocBuilder<MainBottomNavBarCubit, MainBottomNavBarState>(
      builder: (context, state) {
        return SalomonBottomBar(
            selectedColorOpacity: 1,
            backgroundColor: AppColors.secondBackground,
            selectedItemColor: AppColors.primary,
            currentIndex: state.currentMainPage,
            unselectedItemColor: const Color.fromRGBO(96, 96, 98, 1),
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            onTap: (value) {
                menuItems[value]["onTap"]();
              BlocProvider.of<MainBottomNavBarCubit>(context)
                  .changeMainPage(value);
              BlocProvider.of<WatchlistCubit>(context).getWatchlistMovies();
              pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear);
            },
            items: [
              ...List.generate(
                menuItems.length,
                (index) => SalomonBottomBarItem(
                  icon: Icon(
                    menuItems[index]["Icon"],
                    color: state.currentMainPage == index ? Colors.white : null,
                    size: 24,
                  ),
                  title: Text(
                    menuItems[index]["title"],
                    style: TextStyle(
                        height: 1.4,
                        fontFamily: "Poppins",
                        color: state.currentMainPage == index
                            ? Colors.white
                            : null,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              )
            ]);
      },
    );
  }
}
