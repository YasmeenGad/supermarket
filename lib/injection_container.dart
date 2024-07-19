import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supermarket/features/Home/data/datasources/all_products_local_datasource.dart';
import 'package:supermarket/features/Home/data/datasources/product_remote_data_source_impl.dart';
import 'package:supermarket/features/Home/data/repositories/product_repositories_impl.dart';
import 'package:supermarket/features/Home/domain/repositories/product_repository.dart';
import 'package:supermarket/features/Home/domain/usecases/get_all_products_usecase.dart';
import 'package:supermarket/features/Home/domain/usecases/get_best_selling_product_usecase.dart';
import 'package:supermarket/features/Home/presentation/bloc/BestSellingProducts/best_selling_products_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/all_product_bloc/all_products_bloc_bloc.dart';

import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:supermarket/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';
import 'package:supermarket/features/auth/domain/usecases/login_usecase.dart';
import 'package:supermarket/features/auth/domain/usecases/register_usecase.dart';
import 'package:supermarket/features/auth/domain/usecases/sendCode_and_verify_otp_usecase.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/explore/data/datasources/category_local_datasource.dart';
import 'package:supermarket/features/explore/data/datasources/category_remote_datasource.dart';
import 'package:supermarket/features/explore/data/repositories/category_repo_impl.dart';
import 'package:supermarket/features/explore/domain/repositories/category_repo.dart';
import 'package:supermarket/features/explore/domain/usecases/category_usecase.dart';
import 'package:supermarket/features/explore/presentation/bloc/categoruBloc/category_bloc.dart';
import 'package:supermarket/features/search/data/datasources/search_category_remote_datasource.dart';
import 'package:supermarket/features/search/data/datasources/search_remote_datasource.dart';
import 'package:supermarket/features/search/data/repositories/search_category_repo_impl.dart';
import 'package:supermarket/features/search/data/repositories/search_product_repo_impl.dart';
import 'package:supermarket/features/search/domain/repositories/search_category_repo.dart';
import 'package:supermarket/features/search/domain/repositories/search_product_repo.dart';
import 'package:supermarket/features/search/domain/usecases/search_category_usecase.dart';
import 'package:supermarket/features/search/domain/usecases/search_product_usecase.dart';
import 'package:supermarket/features/search/presentation/bloc/search_category_bloc/search_category_bloc.dart';
import 'package:supermarket/features/search/presentation/bloc/search_product_bloc/search_product_bloc.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final pageController = PageController();
  final httpClient = http.Client();
  final internetConnectionChecker = InternetConnectionChecker();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Core
  final networkInfo = NetworkInfoImpl(internetConnectionChecker);

  // Register External dependencies
  sl.registerLazySingleton(() => httpClient);
  sl.registerLazySingleton(() => internetConnectionChecker);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => pageController);

  // Register Core
  sl.registerLazySingleton<NetworkInfo>(() => networkInfo);

  // Auth Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImp(client: httpClient));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  // Product Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(() =>
      ProductRemoteDataSourceImpl(
          client: httpClient, authLocalDataSource: sl()));
  sl.registerLazySingleton<AllProductsLocalDataSource>(() =>
      AllProductsLocalDataSourceImpl(
          sharedPreferences: sharedPreferences)); // Correct registration

  // search data source
  sl.registerLazySingleton<SearchRemoteDataSource>(() =>
      SearchRemoteDatasourceImpl(
          client: httpClient, authLocalDataSource: sl()));

  // explore data source
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(
            client: httpClient,
            authLocalDataSource: sl(),
          ));

  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  // search category data source
  sl.registerLazySingleton<SearchCategoryRemoteDatasource>(
      () => SearchCategoryRemoteDatasourceImpl(
            client: httpClient,
            authLocalDataSource: sl(),
          ));

  // Auth Repositories
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImp(
        authLocalDataSource: sl(),
        authRemoteDatasource: sl(),
        networkInfo: sl(),
      ));

  // Product Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Search Repositories
  sl.registerLazySingleton<SearchProductsRepository>(
      () => SearchProductsRepositoryImpl(
            networkInfo: sl(),
            searchRemoteDatasource: sl(),
          ));

  // explore Repositories
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  // search category Repositories
  sl.registerLazySingleton<SearchCategoryRepository>(
      () => SearchCategoryRepoImpl(
            networkInfo: sl(),
            searchCategoryRemoteDatasource: sl(),
          ));

  // Auth Use cases
  sl.registerLazySingleton(() => LoginUsecase(authRepositories: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));
  sl.registerLazySingleton(() => SendOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(repository: sl()));

  // Product Use cases
  sl.registerLazySingleton(() => GetAllProducts(sl()));

  // Best Selling Products Use Case
  sl.registerLazySingleton(() => GetBestSellingProductUsecase(sl()));

  // search use case
  sl.registerLazySingleton(() => SearchProductUsecase(
        searchProductsRepository: sl(),
      ));

  // explore use case
  sl.registerLazySingleton(() => GetCategoriesUseCase(
        sl(),
      ));

  // search category use case
  sl.registerLazySingleton(() => SearchCategoryUsecase(
        sl(),
      ));

  // Auth Blocs
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        register: sl(),
        sendCode: sl(),
        verifyOtp: sl(),
        resetPassword: sl(),
      ));

  // Product Blocs
  sl.registerFactory(() => AllProductsBlocBloc(
        getAllProducts: sl(),
      ));
  // Best Sellin Products Blocs
  sl.registerFactory(() => BestSellingProductsBloc(
        bestSellingProductUsecase: sl(),
      ));

  // Search Blocs
  sl.registerFactory(() => SearchProductBloc(
        sl(),
      ));

  // explore Blocs
  sl.registerFactory(() => CategoryBloc(
        sl(),
      ));

  // search category Blocs
  sl.registerFactory(() => SearchCategoryBloc(
        CategoryUseCase: sl(),
      ));
}
