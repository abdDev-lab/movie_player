import 'package:flutter_bloc/flutter_bloc.dart';

enum Watchlist { movie, shows }

class SelectMovieOrTvCubit extends Cubit<Watchlist> {
  SelectMovieOrTvCubit() : super(Watchlist.movie);

  void selectMovie() => emit(Watchlist.movie);
  void selectTv() => emit(Watchlist.shows);
}
