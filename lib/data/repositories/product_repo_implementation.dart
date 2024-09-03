import 'package:everlane/data/datasources/product_datasource.dart';
import 'package:everlane/data/models/detailproduct.dart';
import 'package:everlane/domain/entities/product_entity.dart';
import 'package:everlane/repository/product_repo.dart';

import '../models/product_model.dart';

class ProductRepoImplementation extends ProductRepo {
  final ProductRemoteDataSource productRemoteDataSource =
      ProductRemoteDataSourceimpl();
  @override
  Future<List<Product>> getProductFromDataSource() async {
    try {
      final productModels = await productRemoteDataSource.getProductFromApi();
      return productModels
          .map((model) => Product(
              id: model.id??0,
              name: model.name,
              description: model.description,
              price: model.price.toString(),
              brand: model.brand,
              subcategory: model.subcategory,
        createdOn: model.createdOn,
        isDeleted: model.isDeleted,
        isTrending: model.isTrending,
        image: model.image,
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getSeasonsfromDatasource(String seasons) async{
    try {
      final productModels = await productRemoteDataSource.getSeasons(seasons);
      return productModels
          .map((model) => Product(
          id: model.id??0,
          name: model.name,
          description: model.description,
          price: model.price.toString(),
          brand: model.brand,
          subcategory: model.subcategory,
          image: model.image,
        createdOn: model.createdOn,
        isDeleted: model.isDeleted,
        isTrending: model.isTrending,
          ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<ProductEntity>> getfiltercategory(int subcategory) async{
  //   try {
  //     final productModels = await productRemoteDataSource.getfiltercategory(subcategory);
  //     return productModels
  //         .map((model) => ProductEntity(
  //         id: model.id??0,
  //         name: model.name,
  //         description: model.description,
  //         price: model.price.toString(),
  //         brand: model.brand,
  //         subcategory: model.subcategory,
  //         //isTrending: model.isTrending,
  //       createdOn: model.createdOn,
  //       isDeleted: model.isDeleted,
  //       isTrending: model.isTrending,
  //       items:   model.items,
  //       image: model.image,
  //     ))
  //         .toList();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<List<Product>> getfiltercategoryDatasource(int subcategory)async {
    try {
      final productModels = await productRemoteDataSource.getfiltercategory(subcategory);
      return productModels
          .map((model) => Product(
          id: model.id??0,
          name: model.name,
          description: model.description,
          price: model.price.toString(),
          brand: model.brand,
          subcategory: model.subcategory,
          //isTrending: model.isTrending,
          image: model.image,
        createdOn: model.createdOn,
        isDeleted: model.isDeleted,
        isTrending: model.isTrending,

          ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<DetailProduct> getDetailsProductDatasource(int id) async{
  //   try {
  //   final productModels = await productRemoteDataSource.getDetailsProduct(id);
  //   return  DetailProduct(
  //     id: productModels.id??0,
  //     name: productModels.name,
  //     description: productModels.description,
  //     price: productModels.price.toString(),
  //     brand: productModels.brand,
  //     subcategory: productModels.subcategory,
  //     //isTrending: model.isTrending,
  //     image: productModels.image,
  //     createdOn: productModels.createdOn,
  //     isDeleted: productModels.isDeleted,
  //     isTrending: productModels.isTrending,
  //     items: productModels.items.map((item) => Item(
  //       id: item.id,
  //       product: item.product,
  //       size: item.size,
  //       stock: item.stock,
  //       isOutOfStock: item.isOutOfStock,
  //     )).toList(),
  //   );
  // } catch (e) {
  //   rethrow;
  // }
  // }

  @override
  Future<List<Product>> getSearchfromDtasource(String keyword)async {
    try {
      final productModels = await productRemoteDataSource.searchProducts(keyword);
      return productModels
          .map((model) => Product(
        id: model.id??0,
        name: model.name,
        description: model.description,
        price: model.price.toString(),
        brand: model.brand,
        subcategory: model.subcategory,
        //isTrending: model.isTrending,
        image: model.image,
        createdOn: model.createdOn,
        isDeleted: model.isDeleted,
        isTrending: model.isTrending,

      ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }



}
