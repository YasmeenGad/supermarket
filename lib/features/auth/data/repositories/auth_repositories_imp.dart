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
      return Left('No internet connection');
    }

    final endpoint = 'https://supermarket-kiza.onrender.com/user/login';
    final requestBody = {'email': email, 'password': password};
    final requestHeaders = {'Content-Type': 'application/json'};

    try {
      final response = await client.post(Uri.parse(endpoint),
          body: jsonEncode(requestBody), headers: requestHeaders);

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left('Failed to login');
      }
    } catch (e) {
      return Left('Failed to login: $e');
    }
  }

  
  @override
  Future<Either<String, User>> register(
      String username, String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left('No internet connection');
    }

    final endpoint = 'https://supermarket-kiza.onrender.com/user/register';
    final requestBody = {
      'username': username,
      'email': email,
      'password': password
    };

    try {
      final response = await client.post(Uri.parse(endpoint),
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(jsonDecode(response.body)));
      }
      return Left('Registration failed');
    } catch (e) {
      return Left('Registration failed: $e');
    }
  }
}

  

  