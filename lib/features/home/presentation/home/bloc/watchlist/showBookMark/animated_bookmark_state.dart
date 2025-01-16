part of 'animated_bookmark_cubit.dart';

class AnimatedBookmarkState extends Equatable {
  
  const AnimatedBookmarkState();

  @override
  List<Object> get props => [];
}

class StartAnimated extends AnimatedBookmarkState {
  final int mediaId;

  const StartAnimated({required this.mediaId});

    @override
  List<Object> get props => [mediaId];
}
