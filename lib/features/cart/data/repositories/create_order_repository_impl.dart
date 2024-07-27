import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/cart/data/datasources/create_order_local_datasource.dart';
import 'package:supermarket/features/cart/data/datasources/create_order_remote_datasource.dart';
import 'package:supermarket/features/cart/domain/entities/order.dart';
import 'package:supermarket/features/cart/domain/repositories/create_order_repository.dart';

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
      try {
        final cachedOrder = await localDataSource.getLastOrder();
        if (cachedOrder != null) {
          return Right(cachedOrder);
        } else {
          return Left('No internet connection and no cached data available');
        }
      } catch (e) {
        return Left('Failed to get order from local cache: $e');
      }
    }
    try {
      final order = await remoteDataSource.createOrder(productIds);
      localDataSource.cacheOrder(order);
      return Right(order);
    } catch (e) {
      return Left('Failed to create order: $e');
    }
  }
}
