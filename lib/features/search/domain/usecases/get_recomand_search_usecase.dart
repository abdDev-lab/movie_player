import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../repository/search_repository.dart';

class GetRecomandSearchUsecase {
  final SearchRepository searchRepository;

  GetRecomandSearchUsecase({required this.searchRepository});

  Future<Either<Failures, Map>> call(String searchInput) async {
    return await searchRepository.getRecomandSearch(searchInput);
  }
}
