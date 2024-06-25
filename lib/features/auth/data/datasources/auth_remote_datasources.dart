import 'package:supermarket/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String username, String email, String password);
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImp({required this.client});
  @override
  Future<UserModel> login(String email, String password) async {
    final loginUrl =
        Uri.parse('https://supermarket-kiza.onrender.com/user/login');
    final requestBody = {'email': email, 'password': password};
    final requestHeaders = {'Content-Type': 'application/json'};

    try {
      final response = await client.post(loginUrl,
          body: jsonEncode(requestBody), headers: requestHeaders);

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<UserModel> register(
      String username, String email, String password) async {
    final registerUrl =
        Uri.parse('https://supermarket-kiza.onrender.com/user/register');
    final data = {
      'username': username,
      'email': email,
      'password': password,
    };

    try {
      final response = await client.post(
        registerUrl,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      }
      throw Exception('Registration failed');
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }
}