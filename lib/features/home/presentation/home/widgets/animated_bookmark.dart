import 'package:flutter/material.dart';
import 'package:movieplayer/features/home/presentation/home/bloc/watchlist/showBookMark/animated_bookmark_cubit.dart';

class AnimatedBookmark extends StatefulWidget {
  final AnimatedBookmarkCubit animatedBookmarkCubit;
  const AnimatedBookmark({super.key, required this.animatedBookmarkCubit});

  @override
  State<AnimatedBookmark> createState() => _AnimatedBookmarkState();
}

class _AnimatedBookmarkState extends State<AnimatedBookmark>
    with TickerProviderStateMixin {
  late AnimationController animatedBookMark;

  late Animation<double> animation;

  late Animation<double> bookMarkSize;

  @override
  void initState() {
    super.initState();

    animatedBookMark = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 100));
    animation =
        CurvedAnimation(parent: animatedBookMark, curve: Curves.easeInOutCubic);
    bookMarkSize = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 3), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 3, end: 2.8), weight: 1),
    ]).animate(animatedBookMark);
    animate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        width: 100,
        child: ScaleTransition(
          scale: bookMarkSize,
          child: const Icon(Icons.bookmark),
        ));
  }

  void animate() {
    animatedBookMark.addStatusListener(
      (status) {
        if (status.isCompleted) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              animatedBookMark.stop();
              animatedBookMark.reverse();
            },
          );
        }
      },
    );
    animatedBookMark.forward();
  }

  @override
  void dispose() {
    widget.animatedBookmarkCubit.reset();
    animatedBookMark.dispose();
    super.dispose();
  }
}
