// data/repositories/product_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/Home/data/datasources/all_products_local_datasource.dart';
import 'package:supermarket/features/Home/data/datasources/product_remote_data_source_impl.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/Home/data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final AllProductsLocalDataSource  localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
         try {
        final products = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(products);
        return Right(products);
      } catch (e) {
        return Left('Failed to get products: $e');
      }
    } else {
       try {
        final cachedProducts = await localDataSource.getCachedProducts();
        if (cachedProducts.isNotEmpty) {
          return Right(cachedProducts);
        } else {
          return Left('No internet connection and no cached data available');
        }
      } catch (e) {
        return Left('Failed to get products from local cache: $e');
      }
    }
    }

  @override
  Future<Either<String, List<BestSellingProductsModel>>> getBestSellingProducts() async{
    if (await networkInfo.isConnected) {
       try {
        final bestSellingProducts = await remoteDataSource.getBestSellingProducts();
        localDataSource.cacheBestSellingProducts(bestSellingProducts);
        
        return Right(bestSellingProducts);
      } catch (e) {
        return Left('Failed to get products: $e');
      }
    } else {
       try {
        final cachedProducts = await localDataSource.getCachedBestSellingProducts();
        if (cachedProducts.isNotEmpty) {
          return Right(cachedProducts);
        } else {
          return Left('No internet connection and no cached data available');
        }
      } catch (e) {
        return Left('Failed to get products from local cache: $e');
      }
    }
  }
  }
