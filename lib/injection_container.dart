import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:supermarket/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';
import 'package:supermarket/features/auth/domain/usecases/login_usecase.dart';
import 'package:supermarket/features/auth/domain/usecases/register_usecase.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final httpClient = http.Client();
  final internetConnectionChecker = InternetConnectionChecker();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Core
  final networkInfo = NetworkInfoImpl(internetConnectionChecker);

  // Register External dependencies
  sl.registerLazySingleton(() => httpClient);
  sl.registerLazySingleton(() => internetConnectionChecker);
  sl.registerLazySingleton(() => sharedPreferences);

  // Register Core
  sl.registerLazySingleton<NetworkInfo>(() => networkInfo);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImp(client: httpClient));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  // Repositories
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImp(
        authLocalDataSource: sl(),
        authRemoteDatasource: sl(),
        networkInfo: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => LoginUsecase(authRepositories: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        register: sl(),
      ));
}
