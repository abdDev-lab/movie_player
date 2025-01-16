import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../core/configs/assets/app_images.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../../auth/pages/login_page.dart';

class SplashNotAuthBody extends StatelessWidget {
  const SplashNotAuthBody({super.key});

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
                AppColors.secondBackground,
                AppColors.secondBackground,
                AppColors.secondBackground,
                AppColors.secondBackground
              ])),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: Image.asset(AppImages.logoImage,fit: BoxFit.fitWidth,),
                    ),

                    const Text(
                      "Get ready to dive into the greates stories in TV and Film",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                          ),
                          child: const Text(
                            "Subscribe Now",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                            
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            backgroundColor: AppColors.background),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                  TextSpan(
                      text: "  Sign Up",
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))
                ])),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      const TextSpan(
                          text:
                              "By creating an account or signing, you agree to our ",
                          style: TextStyle(
                            color: Colors.white70,
                          )),
                      TextSpan(
                          text: "Terms of Service",
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      const TextSpan(
                          text: " and ",
                          style: TextStyle(color: Colors.white70)),
                      TextSpan(
                          text: "Privacy Policy.",
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
