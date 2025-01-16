import 'package:dartz/dartz.dart';
import '../../../../core/network/failures.dart';
import '../entity/search_entitiy.dart';
import '../repository/search_repository.dart';

class GetSearchedMediaUseCase {
  final SearchRepository searchRepository;

  GetSearchedMediaUseCase({required this.searchRepository});
  Future<Either<Failures, List<SearchEntity>>> call(String searchInput) async {
    return await searchRepository.getSearchedMedia(searchInput);
  }
}
