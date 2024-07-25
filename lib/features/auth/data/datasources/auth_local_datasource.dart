import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/auth/data/models/login_response.dart';
import '../models/user_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> removeCachedToken();
  Future<void> cacheLoginResponse(LoginResponse loginResponse);
  Future<LoginResponse?> getCachedLoginResponse();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const CACHED_USER = 'CACHED_USER';
  static const CASHED_TOKEN = 'CACHED_TOKEN';
  static const CACHED_LOGIN_RESPONSE = 'CACHED_LOGIN_RESPONSE';
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    final userJson = user.toJson();
    await sharedPreferences.setString(CACHED_USER, json.encode(userJson));
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString == null || jsonString.isEmpty) {
      return null; // or handle this case appropriately
    }
    return UserModel.fromJson(jsonDecode(jsonString));
  }

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
    await sharedPreferences.setString(CACHED_LOGIN_RESPONSE, json.encode(responseJson));
  }

  @override
  Future<LoginResponse?> getCachedLoginResponse() async {
    final jsonString = sharedPreferences.getString(CACHED_LOGIN_RESPONSE);
    if (jsonString == null || jsonString.isEmpty) {
      return null; // or handle this case appropriately
    }
    return LoginResponse.fromJson(jsonDecode(jsonString));
  }
}
