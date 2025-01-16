import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../repositories/main_repository.dart';

class GetWatchListUsecase {
  final MainRepository mainRepository;

  GetWatchListUsecase({required this.mainRepository});

  Future<Either<Failures, Set>> call() async {
    return await mainRepository.getWatchlist();
  }
}
