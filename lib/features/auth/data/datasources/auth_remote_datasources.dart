import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String username, String email, String password);
  Future<String> sendOtp(String email);
  Future<String> verifyOtp(String otp);
  Future<String> resetPassword(String token,String newPassword);
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
        final errorResponse = jsonDecode(response.body);
        throw ('${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<UserModel> register(String userName, String email, String password) async {
    final registerUrl = Uri.parse('https://supermarket-kiza.onrender.com/user/register');
    final data = {'userName': userName, 'email': email, 'password': password};

    try {
      final response = await client.post(registerUrl, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return UserModel.fromJson(responseBody['newUser']);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw ('${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  @override
  Future<String> resetPassword(String token, String newPassword) async {
    final url = Uri.parse('https://supermarket-kiza.onrender.com/user/reset');
     final requestBody = {'password': newPassword};
    final requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    try {
      final response = await client.post(url, body: jsonEncode(requestBody), headers: requestHeaders);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return responseBody['message'];
      } else {
        final errorResponse = jsonDecode(response.body);
        throw ('${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  @override
  Future<String> sendOtp(String email) async {
    final url =
        Uri.parse('https://supermarket-kiza.onrender.com/user/sendCode');
    final response = await client.post(
      url,
      body: jsonEncode({'email': email}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  @override
  Future<String> verifyOtp(String otp) async {
    final url = Uri.parse('https://supermarket-kiza.onrender.com/user/verify');
    print('Sending OTP: $otp');
    final response = await client.post(
      url,
      body: jsonEncode({'otp': otp}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      return responseBody['token'];
    } else {
      throw Exception('Failed to verify OTP');
    }
  }
}
