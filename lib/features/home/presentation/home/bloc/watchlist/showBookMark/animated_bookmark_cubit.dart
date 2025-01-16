import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'animated_bookmark_state.dart';

class AnimatedBookmarkCubit extends Cubit<AnimatedBookmarkState> {
  AnimatedBookmarkCubit() : super(const AnimatedBookmarkState());

  void addToWatchList(int mediaId) {
    emit(StartAnimated(mediaId: mediaId));
  }
  
  void reset(){
    emit(const AnimatedBookmarkState());
  }

}
