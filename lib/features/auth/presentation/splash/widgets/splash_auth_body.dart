import 'package:flutter/widgets.dart';
import '../../../../../core/configs/assets/app_images.dart';
import '../../../../../core/configs/theme/app_colors.dart';

class SplashAuthBody extends StatelessWidget {
  const SplashAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.splashBackground,
                ),
                fit: BoxFit.fitHeight),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.secondBackground.withOpacity(0),
                AppColors.secondBackground
              ])),
        ),
      ],
    );
  }
}
