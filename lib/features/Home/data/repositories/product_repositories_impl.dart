import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/exceptions.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/Home/data/datasources/all_products_local_datasource.dart';
import 'package:supermarket/features/Home/data/datasources/product_remote_data_source_impl.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/Home/data/models/product_model.dart';
import 'package:supermarket/features/Home/domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final AllProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(products);
        return Right(products);
      } on ServerException catch (e) {
        if (e.statusCode >= 500) {
          return const Left(InternalServerErrorFailure());
        }
        return Left(ServerFailure(e.message, e.statusCode));
      } on TimeoutException {
        return const Left(TimeoutFailure());
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    } else {
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        if (cachedProducts.isNotEmpty) {
          return Right(cachedProducts);
        } else {
          return Left(CacheFailure());
        }
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<BestSellingProductsModel>>>
      getBestSellingProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final bestSellingProducts =
            await remoteDataSource.getBestSellingProducts();
        localDataSource.cacheBestSellingProducts(bestSellingProducts);

        return Right(bestSellingProducts);
      } on ServerException catch (e) {
        if (e.statusCode >= 500) {
          return const Left(InternalServerErrorFailure());
        }
        return Left(ServerFailure(e.message, e.statusCode));
      } on TimeoutException {
        return const Left(TimeoutFailure());
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    } else {
      try {
        final cachedProducts =
            await localDataSource.getCachedBestSellingProducts();
        if (cachedProducts.isNotEmpty) {
          return Right(cachedProducts);
        } else {
          return Left(CacheFailure());
        }
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> updateQuantity(
      String id, int quantity) async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }

    try {
      final updatedProduct =
          await remoteDataSource.updateQuantity(id, quantity);
      return Right(updatedProduct);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return const Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
