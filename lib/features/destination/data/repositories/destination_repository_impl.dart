import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:travel/core/error/excaption.dart';
import 'package:travel/core/error/failures.dart';
import 'package:travel/core/platform/network_info.dart';
import 'package:travel/features/destination/data/datasources/destination_local_data_source.dart';
import 'package:travel/features/destination/data/datasources/destination_remote_data_source.dart';
import 'package:travel/features/destination/domain/entities/destination_entity.dart';
import 'package:travel/features/destination/domain/repositories/destination_repository.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final NetworkInfo networkInfo;
  final DestinationLocalDataSource localDataSource;
  final DestinationRemoteDataSource remoteDataSource;

  DestinationRepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failures, List<DestinationEntity>>> all() async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDataSource.all();
        await localDataSource.cachedAll(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return const Left(NotFoundFailure('Timeout. No Response'));
      } on NotFoundExcaption catch (e){
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerExcaption {
        return const Left(ServerFailure('Server Error'));
      } catch (e) {
        return const Left(ServerFailure('Something Went Wrong'));
      }
    } else {
      try {
        final result = await localDataSource.getAll();
      return Right(result.map((e) => e.toEntity).toList());
      } on CachedExcaption {
        return const Left(CachedFailure('data is not Present'));
      }
    }
  }

  @override
  Future<Either<Failures, List<DestinationEntity>>> search(String query) async {
    try {
        final result = await remoteDataSource.search(query);
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return const Left(NotFoundFailure('Timeout. No Response'));
      }on NotFoundExcaption catch (e){
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerExcaption {
        return const Left(ServerFailure('Server Error'));
      } on SocketException {
        return const Left(ConnectionFailure('Failed connect to the network'));
      }catch (e) {
        return const Left(ServerFailure('Something Went Wrong'));
      }
  }

  @override
  Future<Either<Failures, List<DestinationEntity>>> top() async {
        try {
        final result = await remoteDataSource.top();
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return const Left(NotFoundFailure('Timeout. No Response'));
      } on NotFoundExcaption catch (e){
        return Left(NotFoundFailure(e.message.toString()));
      } on ServerExcaption {
        return const Left(ServerFailure('Server Error'));
      } on SocketException {
        return const Left(ConnectionFailure('Failed connect to the network'));
      } catch (e) {
        return const Left(ServerFailure('Something Went Wrong'));
      }
  }
}
