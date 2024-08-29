import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/exceptions.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/cart/data/datasources/create_order_local_datasource.dart';
import 'package:supermarket/features/cart/data/datasources/order_remote_datasource.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/entities/delete_order.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';
import 'package:supermarket/features/cart/domain/entities/get_total_order.dart';
import 'package:supermarket/features/cart/domain/repositories/order_repo.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final OrderLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, MyOrder>> createOrder(List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }

    try {
      return Right(await remoteDataSource.createOrder(productIds));
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FetchedOrder>> getOrder() async {
    if (!await networkInfo.isConnected) {
      try {
        final cachedOrder = await localDataSource.getLastFetchedOrder();
        if (cachedOrder != null) {
          return Right(cachedOrder);
        } else {
          return Left(CacheFailure());
        }
      } on ServerException catch (e) {
        if (e.statusCode >= 500) {
          return const Left(InternalServerErrorFailure());
        }
        return Left(ServerFailure(e.message, e.statusCode));
      } on TimeoutException {
        return Left(TimeoutFailure());
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    } else {
      try {
        final fetchedOrder = await remoteDataSource.getOrder();
        await localDataSource.cacheFetchedOrder(fetchedOrder);
        return Right(fetchedOrder);
      } on ServerException catch (e) {
        if (e.statusCode >= 500) {
          return const Left(InternalServerErrorFailure());
        }
        return Left(ServerFailure(e.message, e.statusCode));
      } on TimeoutException {
        return Left(TimeoutFailure());
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, TotalOrder>> calculateOrderTotals() async {
    if (!await networkInfo.isConnected) {
      try {
        final cachedTotalOrder = await localDataSource.getTotalOrder();
        if (cachedTotalOrder != null) {
          return Right(cachedTotalOrder);
        } else {
          return Left(CacheFailure());
        }
      } on ServerException catch (e) {
        if (e.statusCode >= 500) {
          return const Left(InternalServerErrorFailure());
        }
        return Left(ServerFailure(e.message, e.statusCode));
      } on TimeoutException {
        return Left(TimeoutFailure());
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    } else {
      try {
        final totalOrder = await remoteDataSource.getOrderTotals();
        localDataSource.cacheTotalOrder(totalOrder);
        print(totalOrder);
        return Right(totalOrder);
      } on ServerException catch (e) {
        if (e.statusCode >= 500) {
          return const Left(InternalServerErrorFailure());
        }
        return Left(ServerFailure(e.message, e.statusCode));
      } on TimeoutException {
        return Left(TimeoutFailure());
      } catch (e) {
        return Left(GeneralFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, MyOrder>> updateOrder(List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }
    try {
      final order = await remoteDataSource.updateOrder(productIds);

      return Right(order);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteOrder>> deleteOrder(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return Left(NoInternetFailure());
    }
    try {
      final order = await remoteDataSource.deleteOrder(productIds);
      await localDataSource.removeItemFromCache(productIds[0]);
      return Right(order);
    } on ServerException catch (e) {
      if (e.statusCode >= 500) {
        return const Left(InternalServerErrorFailure());
      }
      return Left(ServerFailure(e.message, e.statusCode));
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
