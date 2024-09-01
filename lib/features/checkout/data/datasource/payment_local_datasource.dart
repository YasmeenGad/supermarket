import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/checkout/data/models/create_customer_model.dart';
import 'dart:convert';

abstract class PaymentLocalDatasource {
  Future<void> cacheCustomer(CustomerModel customer);
  Future<CustomerModel?> getCachedCustomer();
}

class PaymentLocalDatasourceImpl implements PaymentLocalDatasource {
  static const CACHED_CUSTOMER = 'CACHED_CUSTOMER';
  final SharedPreferences sharedPreferences;

  PaymentLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCustomer(CustomerModel customer) async {
    final customerJson = json.encode(customer.toJson());
    await sharedPreferences.setString(CACHED_CUSTOMER, customerJson);
  }

  @override
  Future<CustomerModel?> getCachedCustomer() async {
    final customerJson = sharedPreferences.getString(CACHED_CUSTOMER);
    if (customerJson != null) {
      return CustomerModel.fromJson(json.decode(customerJson));
    }
    return null;
  }
}
