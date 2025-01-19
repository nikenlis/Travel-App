import 'package:travel/core/error/failures.dart';
import 'package:travel/features/destination/domain/entities/destination_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DestinationRepository {
  Future<Either<Failures, List<DestinationEntity>>> all();
  Future<Either<Failures, List<DestinationEntity>>> top();
  Future<Either<Failures, List<DestinationEntity>>> search(String query);
}

//Nanti implementasinya ada di kelas repositoiresnya data, karna kelas ini kan bentunya abstract