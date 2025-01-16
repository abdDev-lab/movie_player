import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../../../../core/shared/entities/tranding_entity.dart';
import '../repositories/main_repository.dart';


class GetTrandingUsecase {
  final MainRepository trandingRepository;

  GetTrandingUsecase({required this.trandingRepository});

  Future<Either<Failures, List<Tranding>>> call() async {
    return await trandingRepository.getTranding();
  }
}
