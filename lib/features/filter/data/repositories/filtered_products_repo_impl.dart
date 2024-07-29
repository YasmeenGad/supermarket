import 'package:dartz/dartz.dart';
import 'package:supermarket/core/network/network_info.dart';
import 'package:supermarket/features/filter/data/datasources/filtered_products_local_datasource.dart';
import 'package:supermarket/features/filter/data/datasources/filtered_products_remote_datasource.dart';
import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';
import 'package:supermarket/features/filter/domain/repositories/filtered_products_repo.dart';

class FilteredProductsRepositoryImpl implements FilteredProductsRepository {
  final FilteredProductsRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  final FilteredProductsLocalDatasource localDataSource;

  FilteredProductsRepositoryImpl(
      this.remoteDataSource, this.networkInfo, this.localDataSource);

  @override
  Future<Either<String, List<FilteredProducts>>> getProductsByCategory(
      String categoryName) async {
    if (!await networkInfo.isConnected) {
      final localProducts = await localDataSource.getLastProductsByCategory();
      return Right(localProducts
          .map((model) => FilteredProducts(
                id: model.id,
                quantity: model.quantity,
                productName: model.productName,
                price: model.price,
                productDetail: model.productDetail,
                rate: model.rate,
                photo: model.photo,
                bestSelling: model.bestSelling,
              ))
          .toList());
    } else {
      try {
        final remoteProducts =
            await remoteDataSource.getProductsByCategory(categoryName);
        localDataSource.cacheProductsByCategory(remoteProducts);
        return Right(remoteProducts
            .map((model) => FilteredProducts(
                  id: model.id,
                  quantity: model.quantity,
                  productName: model.productName,
                  price: model.price,
                  productDetail: model.productDetail,
                  rate: model.rate,
                  photo: model.photo,
                  bestSelling: model.bestSelling,
                ))
            .toList());
      } catch (e) {
        return Left(e.toString());
      }
    }
  }
}
