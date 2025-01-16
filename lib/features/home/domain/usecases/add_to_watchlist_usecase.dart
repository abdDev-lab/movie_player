import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../repositories/main_repository.dart';

class AddToWatchlistUsecase {
  final MainRepository mainRepository;

  AddToWatchlistUsecase({required this.mainRepository});

  Future<Either<Failures, Unit>> call(int mediaId, String mediaType) async {
    return await mainRepository.addToWatchlist(mediaId, mediaType);
  }
}
