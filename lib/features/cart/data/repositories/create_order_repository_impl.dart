import 'package:dartz/dartz.dart';
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
  Future<Either<String, MyOrder>> createOrder(List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return const Left('No internet connection');
    }

    try {
      return Right(await remoteDataSource.createOrder(productIds));
    } catch (e) {
      return Left('Failed to create order');
    }
  }

  @override
  Future<Either<String, FetchedOrder>> getOrder() async {
    if (!await networkInfo.isConnected) {
      try {
        final cachedOrder = await localDataSource.getLastFetchedOrder();
        if (cachedOrder != null) {
          return Right(cachedOrder);
        } else {
          return Left('No internet connection and no cached data available');
        }
      } catch (e) {
        return Left('Failed to get order from local cache');
      }
    } else {
      try {
        final fetchedOrder = await remoteDataSource.getOrder();
        await localDataSource.cacheFetchedOrder(fetchedOrder);
        return Right(fetchedOrder);
      } catch (e) {
        return Left('Failed to get order');
      }
    }
  }

  @override
  Future<Either<String, TotalOrder>> calculateOrderTotals(
      ) async {
    if (!await networkInfo.isConnected) {
      try {
        final cachedTotalOrder = await localDataSource.getTotalOrder();
        if (cachedTotalOrder != null) {
          return Right(cachedTotalOrder);
        } else {
          return Left('No internet connection and no cached data available');
        }
      } catch (e) {
        return Left('Failed to get total order from local cache: $e');
      }
    } else {
      try {
        final totalOrder = await remoteDataSource.getOrderTotals();
        localDataSource.cacheTotalOrder(totalOrder);
        print(totalOrder);
        return Right(totalOrder);
      } catch (e) {
        print(e.toString());
        return Left('Failed to calculate total order: $e');
      }
    }
  }

  @override
  Future<Either<String, MyOrder>> updateOrder(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    }
    try {
      final order = await remoteDataSource.updateOrder( productIds);
      print(order);
      return Right(order);
    } catch (e) {
      print(e.toString());
      return Left('Failed to update order: $e');
    }
  }

  @override
  Future<Either<String, DeleteOrder>> deleteOrder(
      List<String> productIds) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    }
    try {
      final order = await remoteDataSource.deleteOrder(productIds);
      await localDataSource.removeItemFromCache(productIds[0]);
      return Right(order);
    } catch (e) {
      return Left('Failed to delete order');
    }
  }
}
