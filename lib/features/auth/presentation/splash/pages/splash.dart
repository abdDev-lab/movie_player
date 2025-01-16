import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubit/splash_cubit.dart';
import '../widgets/splash_auth_body.dart';
import '../widgets/splash_not_auth_body.dart';
import '../../../../home/presentation/main/page/main_page.dart';

// shared prefrecese
// if is login take him to home page
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
          }
        },
        builder: (context, state) {
          if (state is NotAuthenticated) {
            return const SplashNotAuthBody();
          }
          return const SplashAuthBody();
        },
      ),
    );
  }
}
