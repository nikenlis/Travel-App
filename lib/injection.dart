

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/core/platform/network_info.dart';
import 'package:travel/features/destination/data/datasources/destination_local_data_source.dart';
import 'package:travel/features/destination/data/repositories/destination_repository_impl.dart';
import 'package:travel/features/destination/domain/repositories/destination_repository.dart';
import 'package:travel/features/destination/domain/usecases/get_all_destination_usecase.dart';
import 'package:travel/features/destination/presentation/bloc/all_destination/all_destination_bloc.dart';

import 'package:http/http.dart' as http;
import 'features/destination/data/datasources/destination_remote_data_source.dart';
import 'features/destination/domain/usecases/get_search_destination_usecase.dart';
import 'features/destination/domain/usecases/get_top_destination_usecase.dart';
import 'features/destination/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'features/destination/presentation/bloc/top_destination/top_destination_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async{
  //bloc 
  locator.registerFactory(() => AllDestinationBloc(locator()));
  locator.registerFactory(() => SearchDestinationBloc(locator()));
  locator.registerFactory(() => TopDestinationBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetAllDestinationUsecase(locator()));
  locator.registerLazySingleton(() => GetSearchDestinationUsecase(locator()));
  locator.registerLazySingleton(() => GetTopDestinationUsecase(locator()));

  //repository
  locator.registerLazySingleton<DestinationRepository>(() => DestinationRepositoryImpl(networkInfo: locator(), localDataSource: locator(), remoteDataSource: locator()));

  //datasource
  locator.registerLazySingleton<DestinationLocalDataSource>(() => DestinationLocalDataSourceImp(pref: locator()));
  locator.registerLazySingleton<DestinationRemoteDataSource>(() => DestinationRemoteDataSourceImpl(client: locator()));

  //platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: locator()));

  //external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());

}