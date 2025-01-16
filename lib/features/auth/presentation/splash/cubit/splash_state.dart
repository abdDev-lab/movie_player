part of 'splash_cubit.dart';

sealed class SplashState {}

final class DisplaySplash extends SplashState {}

final class Authenticated extends SplashState {}

final class NotAuthenticated extends SplashState {}
