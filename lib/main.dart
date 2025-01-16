import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/configs/theme/app_theme.dart';
import 'features/auth/presentation/splash/cubit/splash_cubit.dart';
import 'features/auth/presentation/splash/pages/splash.dart';
import 'features/home/presentation/home/bloc/watchlist/showBookMark/animated_bookmark_cubit.dart';
import 'features/home/presentation/home/bloc/watchlist/watchlist_cubit.dart';
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(sl())..appStarter(),
        ),
        BlocProvider(
            create: (context) => sl<WatchlistMediaCubit>()..getWatchList()),
        BlocProvider(
          create: (context) => AnimatedBookmarkCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          home: const SplashPage()),
    );
  }
}
