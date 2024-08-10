import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/favorite/data/models/favorite_data_model.dart';
import 'package:supermarket/features/favorite/data/models/favorite_products_models.dart';

abstract class FavoritesRemoteDataSource {
  Future<AddFavoriteModel> addFavoriteProducts(List<String> productIds);
  Future<FavoriteModel> getFavoriteProducts(String id);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  FavoritesRemoteDataSourceImpl({
    required this.authLocalDataSource,
    required this.client,
  });

  @override
  Future<AddFavoriteModel> addFavoriteProducts(List<String> productIds) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final cachedToken = token?.token ?? '';

    final url = Uri.parse('http://$ip:4000/favorite/add');
    final response = await client.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $cachedToken',
      },
      body: json.encode({'products': productIds}),
    );
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return AddFavoriteModel.fromJson(decodedJson);
    } else {
      throw Exception('Failed to add favorite products: ${response.body}');
    }
  }
  
  @override
  Future<FavoriteModel> getFavoriteProducts(String id) async{
    final token = await authLocalDataSource.getCachedLoginResponse();
    final cachedToken = token?.token ?? '';
    final response = await client.get(
      Uri.parse('http://$ip:4000/favorite/getFav/$id'),
      headers: {
        'Authorization': 'Bearer $cachedToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return FavoriteModel.fromJson(json.decode(response.body));
    } else {
      throw 'Failed to get favorite products';
    }
  }
  }

