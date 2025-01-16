import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../repositories/main_repository.dart';

class RemoveFromWatchlistUsecase {
  final MainRepository mainRepository;

  RemoveFromWatchlistUsecase({required this.mainRepository});

  Future<Either<Failures, Unit>> call(int mediaId, String mediaType) async {
    return await mainRepository.removeFromWatchlist(mediaId, mediaType);
  }
}
