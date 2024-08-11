import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'dart:convert';

import 'package:supermarket/features/favorite/data/models/add_favorite_model.dart';
import 'package:supermarket/features/favorite/data/models/get_favorite_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<AddFavoriteModel> addFavoriteProducts(List<String> productIds);
  Future<GetFavoriteModel> getFavoriteProducts();
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  FavoriteRemoteDataSourceImpl(
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
      print(responseBody['message']);
      return AddFavoriteModel.fromJson(responseBody['favorites']);
    } else {
      print('Failed to add favorite products');
      print(response.body);
      throw Exception('Failed to add favorite products');
    }
  }

  @override
  Future<GetFavoriteModel> getFavoriteProducts() async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final accessToken = token?.token ?? '';
    final url = Uri.parse('http://$ip:4000/favorite/getFav');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['fav'] != null && jsonResponse['fav'] is List) {
        final favoriteList = (jsonResponse['fav'] as List)
            .map((favJson) => GetFavoriteModel.fromJson(favJson))
            .toList();
        return favoriteList.first;
      } else {
        throw Exception('Invalid favorite products data');
      }
    } else {
      throw Exception('Failed to retrieve favorite products');
    }
  }
}
