import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String email, String password);
  Future<String> register(String username, String email, String password);
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImp({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final loginUrl = Uri.parse('https://supermarket-kiza.onrender.com/user/login');
    final requestBody = {'email': email, 'password': password};
    final requestHeaders = {'Content-Type': 'application/json'};

    try {
      final response = await client.post(loginUrl, body: jsonEncode(requestBody), headers: requestHeaders);

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        final errorResponse = jsonDecode(response.body);
        throw ('${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<String> register(String userName, String email, String password) async {
    final registerUrl = Uri.parse('https://supermarket-kiza.onrender.com/user/register');
    final data = {
      'userName': userName,
      'email': email,
      'password': password,
    };

    try {
      final response = await client.post(
        registerUrl,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return responseBody['message']; // Return the message from the response
      } else {
        final errorResponse = jsonDecode(response.body);
        throw ('${errorResponse['message']}');
      }
    } on Exception catch (e) {
      throw Exception('Failed to register: $e');
    }
  }
}
