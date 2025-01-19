import 'package:dartz/dartz.dart';
import 'package:travel/features/destination/domain/repositories/destination_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/destination_entity.dart';

class GetSearchDestinationUsecase {
  final DestinationRepository repository;
  GetSearchDestinationUsecase(this.repository,
);

  Future<Either<Failures, List<DestinationEntity>>> execute ({required String query}) {
    return repository.search(query);
  }
}
