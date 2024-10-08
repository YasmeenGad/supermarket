import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/auth/data/models/login_response.dart';
import 'package:supermarket/features/checkout/data/models/create_customer_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> removeCachedToken();
  Future<void> cacheLoginResponse(LoginResponse loginResponse);
  Future<LoginResponse?> getCachedLoginResponse();
  Future<void> cacheCustomer(CustomerModel customer);
  Future<CustomerModel?> getCachedCustomer();
  Future<void> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const CACHED_USER = 'CACHED_USER';
  static const CASHED_TOKEN = 'CACHED_TOKEN';
  static const CACHED_LOGIN_RESPONSE = 'CACHED_LOGIN_RESPONSE';
  static const CACHED_CUSTOMER = 'CACHED_CUSTOMER';
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(CASHED_TOKEN, token);
  }

  @override
  Future<String?> getCachedToken() async {
    return sharedPreferences.getString(CASHED_TOKEN);
  }

  @override
  Future<void> removeCachedToken() async {
    await sharedPreferences.remove(CASHED_TOKEN);
  }

  @override
  Future<void> cacheLoginResponse(LoginResponse loginResponse) async {
    final responseJson = loginResponse.toJson();
    await sharedPreferences.setString(
        CACHED_LOGIN_RESPONSE, json.encode(responseJson));
  }

  @override
  Future<LoginResponse?> getCachedLoginResponse() async {
    final jsonString = sharedPreferences.getString(CACHED_LOGIN_RESPONSE);
    if (jsonString == null || jsonString.isEmpty) {
      return null; // or handle this case appropriately
    }
    return LoginResponse.fromJson(jsonDecode(jsonString));
  }

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

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(CASHED_TOKEN);
    await sharedPreferences.remove(CACHED_LOGIN_RESPONSE);
  }
}
