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
import 'package:supermarket/features/Home/presentation/bloc/BestSellingProducts/best_selling_products_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/all_product_bloc/all_products_bloc_bloc.dart';
import 'package:supermarket/features/Home/presentation/bloc/update_quantity/update_quantity_bloc.dart';

import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:supermarket/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';
import 'package:supermarket/features/auth/domain/usecases/auth_usecase.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/cart/data/datasources/create_order_local_datasource.dart';
import 'package:supermarket/features/cart/data/datasources/order_remote_datasource.dart';
import 'package:supermarket/features/cart/data/repositories/create_order_repository_impl.dart';
import 'package:supermarket/features/cart/domain/repositories/order_repo.dart';
import 'package:supermarket/features/cart/domain/usecases/order_usecase.dart';
import 'package:supermarket/features/cart/presentation/bloc/delete_item_bloc/delete_item_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_total_order.dart/get_total_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:supermarket/features/cart/presentation/bloc/get_order_bloc/get_order_bloc.dart';
import 'package:supermarket/features/checkout/data/datasource/payment_remote_datasource.dart';
import 'package:supermarket/features/checkout/data/repositories/payment_repo_impl.dart';
import 'package:supermarket/features/checkout/domain/repositories/payment_repo.dart';
import 'package:supermarket/features/checkout/domain/usecase/payment_usecase.dart';
import 'package:supermarket/features/checkout/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:supermarket/features/checkout/presentation/bloc/payment_bloc/payment_bloc.dart';
import 'package:supermarket/features/explore/data/datasources/category_local_datasource.dart';
import 'package:supermarket/features/explore/data/datasources/category_remote_datasource.dart';
import 'package:supermarket/features/explore/data/repositories/category_repo_impl.dart';
import 'package:supermarket/features/explore/domain/repositories/category_repo.dart';
import 'package:supermarket/features/explore/domain/usecases/category_usecase.dart';
import 'package:supermarket/features/explore/presentation/bloc/categoruBloc/category_bloc.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_local_datasource.dart';
import 'package:supermarket/features/favorite/data/datasources/favorite_remote_datasource.dart';
import 'package:supermarket/features/favorite/data/repositories/favorite_repo_impl.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorite_repo.dart';
import 'package:supermarket/features/favorite/domain/usecases/favorite_usecase.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_fav_products/add_favorite_product_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/delete_all_fav/delete_all_favorite_products_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/delete_one_fav_products/delete_one_favorite_product_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_fav_products/get_favorite_products_bloc.dart';
import 'package:supermarket/features/filter/data/datasources/filtered_products_local_datasource.dart';
import 'package:supermarket/features/filter/data/datasources/filtered_products_remote_datasource.dart';
import 'package:supermarket/features/filter/data/repositories/filtered_products_repo_impl.dart';
import 'package:supermarket/features/filter/domain/repositories/filtered_products_repo.dart';
import 'package:supermarket/features/filter/domain/usecases/filtered_products_usecase.dart';
import 'package:supermarket/features/filter/presentation/bloc/filtered_products_bloc/filtered_products_bloc.dart';
import 'package:supermarket/features/search/data/datasources/search_remote_datasource.dart';
import 'package:supermarket/features/search/data/repositories/search_product_repo_impl.dart';
import 'package:supermarket/features/search/domain/repositories/search_product_repo.dart';
import 'package:supermarket/features/search/domain/usecases/search_product_usecase.dart';
import 'package:supermarket/features/explore/presentation/bloc/search_category_bloc/search_category_bloc.dart';
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

  // filter products remote data source
  sl.registerLazySingleton<FilteredProductsRemoteDatasource>(
      () => FilteredProductsRemoteDatasourceImpl(
            client: httpClient,
            authLocalDataSource: sl(),
          ));
  // filter products local data source
  sl.registerLazySingleton<FilteredProductsLocalDatasource>(
    () => FilteredProductsLocalDatasourceImpl(
        sharedPreferences: sharedPreferences),
  );

  // create order remote data source
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(
      client: httpClient,
      authLocalDataSource: sl(),
    ),
  );
  // add favorite remote data source
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(
      client: httpClient,
      authLocalDataSource: sl(),
    ),
  );
// add favorite local data source
  sl.registerLazySingleton<FavoriteLocalDataSource>(
    () => FavoriteLocalDataSourceImpl(
      sharedPreferences: sharedPreferences,
    ),
  );
  // create order local data source
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  // payment remote data source
  sl.registerLazySingleton<PaymentRemoteDatasource>(
    () => PaymentRemoteDatasourceImpl(
      client: httpClient,
    ),
  );

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

  // explore Repositories
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  // Filter Products Repositories
  sl.registerLazySingleton<FilteredProductsRepository>(
      () => FilteredProductsRepositoryImpl(
            sl(),
            sl(),
            sl(),
          ));

  // create order Repositories
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  // search Repositories
  sl.registerLazySingleton<SearchProductsRepository>(
    () => SearchProductsRepositoryImpl(
      networkInfo: sl(),
      searchRemoteDatasource: sl(),
    ),
  );
  // add favorite Repositories
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  // payment Repositories
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      networkInfo: sl(),
      paymentRemoteDatasource: sl(),
    ),
  );
  // Auth Use cases
  sl.registerLazySingleton(() => AuthUsecase(authRepositories: sl()));

  // Product Use cases
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));

  // search use case
  sl.registerLazySingleton(() => SearchProductUsecase(
        searchProductsRepository: sl(),
      ));

  // explore use case
  sl.registerLazySingleton(() => CategoryUsecase(
        sl(),
      ));

  // Filter Products use case
  sl.registerLazySingleton(() => FilteredProductsUsecase(
        sl(),
      ));

  //order use case
  sl.registerLazySingleton(() => OrderUsecases(
        repository: sl(),
      ));

  // add favorite use case
  sl.registerLazySingleton(() => AddFavoriteProductsUseCase(
        sl(),
      ));

  // payment use case
  sl.registerLazySingleton(() => PaymentUsecase(
        paymentRepository: sl(),
      ));

  // Auth Blocs
  sl.registerFactory(() => AuthBloc(
        authUsecase: sl(),
      ));

  // Product Blocs
  sl.registerFactory(() => AllProductsBlocBloc(
        getProductsUseCase: sl(),
      ));
  // Best Sellin Products Blocs
  sl.registerFactory(() => BestSellingProductsBloc(
        getProductsUseCase: sl(),
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

  // Filter Products Blocs
  sl.registerFactory(() => FilteredProductsBloc(
        filteredProductsUsecase: sl(),
      ));

  // create order Blocs
  sl.registerFactory(() => CreateOrderBloc(
        orderUsecases: sl(),
      ));

  // fetch order Blocs
  sl.registerFactory(() => GetOrderBloc(
        getOrderUseCase: sl(),
      ));

  // total order Blocs
  sl.registerFactory(() => GetTotalOrderBloc(
        totalOderUsecase: sl(),
      ));

  // add favorite Blocs
  sl.registerFactory(() => AddFavoriteProductBloc(
        sl(),
      ));

  // get favorite products Blocs
  sl.registerFactory(() => GetFavoriteProductsBloc(
        sl(),
      ));

  // delete favorite products Blocs
  sl.registerFactory(() => DeleteOneFavoriteProductBloc(
        sl(),
      ));

  // delete all favorite products Blocs
  sl.registerFactory(() => DeleteAllFavoriteProductsBloc(
        sl(),
      ));

  // delete item from cart Blocs
  sl.registerFactory(() => DeleteItemBloc(
        sl(),
      ));
  // update quantity Blocs
  sl.registerFactory(() => UpdateQuantityBloc(
        sl(),
      ));

  // payment Blocs
  sl.registerFactory(() => PaymentBloc(
        paymentUsecase: sl(),
      ));

  // create customer bloc
  sl.registerFactory(() => CustomerBloc(
        paymentUsecase: sl(),
      ));
}
