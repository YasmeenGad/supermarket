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
      status: json['status'] ?? false, // Handle missing key or null value
      message: json['message'] ??
          '', // Default empty string for missing or null message
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
