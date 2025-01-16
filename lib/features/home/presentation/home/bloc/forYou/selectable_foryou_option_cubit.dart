import "package:flutter_bloc/flutter_bloc.dart";



enum ForyouType { movie, shows }

class SelectableForyouOptionCubit extends Cubit<ForyouType> {
  SelectableForyouOptionCubit() : super(ForyouType.movie);

  void selectMovie() => emit(ForyouType.movie);
  void selectTv() => emit(ForyouType.shows);
}
