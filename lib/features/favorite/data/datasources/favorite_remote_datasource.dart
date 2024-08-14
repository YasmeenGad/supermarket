import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/favorite/data/models/add_favorite_model.dart';
import 'package:supermarket/features/favorite/data/models/delete_all_favorite_products_model.dart';
import 'package:supermarket/features/favorite/data/models/delete_one_favorite_product_model.dart';
import 'package:supermarket/features/favorite/data/models/get_favorite_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<AddFavoriteModel> addFavoriteProducts(List<String> productIds);
  Future<GetFavoriteModel> getFavoriteProducts();
  Future<DeleteOneFavoriteProductModel> deleteOneFavoriteProduct(List<String> productIds);
  Future<DeleteAllFavoriteProductsModel> deleteAllFavoriteProducts();
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  FavoriteRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
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
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      return AddFavoriteModel.fromJson(responseBody['favorites']);
    } else {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final errorMessage = responseBody['message'] ?? 'Failed to add favorite products';
      throw Exception(errorMessage);
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
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      final favList = jsonResponse['fav'] as List?;
      
      if (favList != null && favList.isNotEmpty) {
        final favoriteList = favList
            .map((favJson) => GetFavoriteModel.fromJson(favJson as Map<String, dynamic>))
            .toList();
        return favoriteList.first;
      } else {
        throw Exception('Empty favorite products list');
      }
    } else {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final errorMessage = responseBody['message'] ?? 'Failed to retrieve favorite products';
      throw Exception(errorMessage);
    }
  }

  @override
  Future<DeleteOneFavoriteProductModel> deleteOneFavoriteProduct(List<String> productIds) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final accessToken = token?.token ?? '';
    final url = Uri.parse('http://$ip:4000/favorite/one');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode({'products': productIds});

    final response = await client.delete(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      return DeleteOneFavoriteProductModel.fromJson(responseBody['favorites']);
    } else {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final errorMessage = responseBody['message'] ?? 'Failed to delete the product from favorites';
      throw Exception(errorMessage);
    }
  }
  
  @override
  Future<DeleteAllFavoriteProductsModel> deleteAllFavoriteProducts() async{
    final token = await authLocalDataSource.getCachedLoginResponse();
    final accessToken = token?.token ?? '';
    final url = Uri.parse('http://$ip:4000/favorite/all');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final response = await client.delete(url, headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      return DeleteAllFavoriteProductsModel.fromJson(responseBody['favorites']);
    } else {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final errorMessage = responseBody['message'] ?? 'Failed to delete all products from favorites';
      throw Exception(errorMessage);
    }
  }
}
