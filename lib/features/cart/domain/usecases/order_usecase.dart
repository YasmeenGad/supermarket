import 'package:dartz/dartz.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';
import 'package:supermarket/features/cart/domain/repositories/order_repo.dart';

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase({required this.repository});

  Future<Either<String, MyOrder>> call(List<String> productIds) async {
    return await repository.createOrder(productIds);
  }
}

class GetOrderUseCase{
  final OrderRepository repository;
  GetOrderUseCase({required this.repository});

  Future<Either<String, List<FetchedOrder>>> call() async {
    return await repository.getOrder();
  }
}