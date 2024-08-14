import 'package:supermarket/features/cart/domain/entities/delete_order.dart';

class DeleteOrderModel extends DeleteOrder {
  DeleteOrderModel({
    required bool status,
    required String message,
  }) : super(status: status, message: message);

  factory DeleteOrderModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON data is null');
    }
    return DeleteOrderModel(
      status: json['status'] ?? false, 
      message: json['message'] ??
          '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
