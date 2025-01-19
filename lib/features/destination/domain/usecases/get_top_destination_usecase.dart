import 'package:dartz/dartz.dart';
import 'package:travel/features/destination/domain/repositories/destination_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/destination_entity.dart';

class GetTopDestinationUsecase {
  final DestinationRepository repository;
  GetTopDestinationUsecase(this.repository);

  Future<Either<Failures, List<DestinationEntity>>> execute () {
    return repository.top();
  }
}
