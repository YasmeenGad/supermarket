import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> removeCachedToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const CACHED_USER = 'CACHED_USER';
  static const CASHED_TOKEN = 'CACHED_TOKEN';
  static const CASHED_USERNAME = 'CASHED_USERNAME';
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

    return UserModel.fromJson(jsonDecode(jsonString ?? ''));
  }

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(CASHED_TOKEN, token);
  }

  @override
  Future<String?> getCachedToken() async {
    return await sharedPreferences.getString(CASHED_TOKEN);
  }

  @override
  Future<void> removeCachedToken() async {
    await sharedPreferences.remove(CASHED_TOKEN);
  }
}
