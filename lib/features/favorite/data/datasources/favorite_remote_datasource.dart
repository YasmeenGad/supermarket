import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'dart:convert';

import 'package:supermarket/features/favorite/data/models/add_favorite_model.dart';

class FavoriteRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  FavoriteRemoteDataSource(
      {required this.client, required this.authLocalDataSource});

  Future<AddFavoriteModel> addFavoriteProducts(List<String> productIds) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final accessToken = token?.token ?? '';
    final url = Uri.parse('http://$ip:4000/favorite/addFav');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode({'products': productIds});

    final response = await client.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return AddFavoriteModel.fromJson(responseBody['favorites']);
    } else {
      throw Exception('Failed to add favorite products');
    }
  }
}
