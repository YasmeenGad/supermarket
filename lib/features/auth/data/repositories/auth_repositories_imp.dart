import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/auth/data/models/user_model.dart';
import 'package:supermarket/features/auth/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:supermarket/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final http.Client client;
  final NetworkInfo networkInfo;

  AuthRepositoriesImp({required this.client, required this.networkInfo});

  @override
  Future<Either<String, User>> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left(Exception('No internet connection') as String);
    }

    final url = Uri.parse('https://supermarket-kiza.onrender.com/user/login');
    final body = {'email': email, 'password': password};
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await client.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left(Exception('Failed to login') as String);
      }
    } catch (e) {
      return Left(Exception('Failed to login: $e') as String);
    }
  }

  
  @override
  Future<Either<String, User>> register(
      String userName, String userEmail, String userPassword) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    }

    final baseUrl = 'https://supermarket-kiza.onrender.com/user/register';
    final requestBody = {'username': userName, 'email': userEmail, 'password': userPassword};
    final requestHeaders = {'Content-Type': 'application/json'};

    try {
      final response = await client.post(Uri.parse(baseUrl),
          body: jsonEncode(requestBody), headers: requestHeaders);

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left('Registration failed');
      }
    } catch (e) {
      return Left('Registration failed: $e');
    }
  }
}

  

  