import 'package:dartz/dartz.dart';
import 'package:supermarket/features/cart/domain/entities/order.dart';
import 'package:supermarket/features/cart/domain/repositories/create_order_repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase({required this.repository});

  Future<Either<String, MyOrder>> call(List<String> productIds) async {
    return await repository.createOrder(productIds);
  }
}