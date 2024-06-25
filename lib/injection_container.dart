import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:supermarket/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:supermarket/features/auth/domain/usecases/login_usecase.dart';
import 'package:supermarket/features/auth/domain/usecases/register_usecase.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';

import 'core/network/network_info.dart';


final sl = GetIt.instance;


Future<void> init() async {

  // Initializes the dependencies for the 'feature auth' module 
  final httpClient = http.Client();
  final internetConnectionChecker = InternetConnectionChecker();
  final sharedPreferences = await SharedPreferences.getInstance();
  final networkInfo = NetworkInfoImpl(internetConnectionChecker);
  

  // data sources
  final authRemoteDatasource = AuthRemoteDatasourceImp(client: httpClient);
  final authLocalDataSource = AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences);

  // repositories
  final authRepositories = AuthRepositoriesImp(
    authLocalDataSource: authLocalDataSource,
    authRemoteDatasource: authRemoteDatasource,
    networkInfo: networkInfo,
  );
  
  // use cases
  final loginUseCase = LoginUsecase(authRepositories: authRepositories);
  final registerUseCase = RegisterUsecase(authRepositories: authRepositories);
  
  // bloc
  final authBloc = AuthBloc(
    login: loginUseCase,
    register: registerUseCase,
  );
  
  // register all the dependencies
  sl.registerLazySingleton(() => httpClient);
  sl.registerLazySingleton(() => internetConnectionChecker);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => networkInfo);
  sl.registerLazySingleton(() => authRemoteDatasource);
  sl.registerLazySingleton(() => authLocalDataSource);
  sl.registerLazySingleton(() => authRepositories);
  sl.registerLazySingleton(() => loginUseCase);
  sl.registerLazySingleton(() => registerUseCase);
  sl.registerFactory(() => authBloc);
}
