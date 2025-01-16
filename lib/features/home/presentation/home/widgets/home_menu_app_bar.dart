import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../bloc/menuAppBar/menu_app_bar_cubit.dart';

class HomeMenuAppBar extends StatelessWidget {
  const HomeMenuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> menu = ["All", "Movies", "Shows", "Sport", "News"];

    return BlocBuilder<MenuAppBarCubit, MenuAppBarState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is CategoryState) {
          selectedIndex = state.categoryIndex;
        }
        return SizedBox(

          height: 36,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only( right: 16),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      BlocProvider.of<MenuAppBarCubit>(context)
                          .selectCategory(index);
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: index == selectedIndex
                                ? AppColors.primary
                                : Colors.transparent),
                        child: AnimatedDefaultTextStyle(
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: index == selectedIndex
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                            duration: const Duration(milliseconds: 150),
                            child: Text(
                              menu[index],
                            ))),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 4,
                  ),
              itemCount: menu.length),
        );
      },
    );
  }
}
