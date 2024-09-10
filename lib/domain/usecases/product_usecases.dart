import 'package:everlane/data/datasources/product_datasource.dart';
import 'package:everlane/data/repositories/product_repo_implementation.dart';
import 'package:everlane/repository/product_repo.dart';

import '../../data/models/detailproduct.dart';
import '../../data/models/product_model.dart';

class ProductUsecases {
  final ProductRepo productRepo=ProductRepoImplementation();
final   ProductRemoteDataSourceimpl productData=ProductRemoteDataSourceimpl();
  //ProductUsecases(this.productRepo);

  Future<List<Product>> getProductFromDatasource() async {

    final product = await productRepo.getProductFromDataSource();
    return product;
  }
  Future<List<Product>> getSeasonsfromDatasource(String seasons) async {
    final season = await productRepo.getSeasonsfromDatasource(seasons);
    return season;
  }
  Future<List<Product>> getfiltercategoryDatasource(int subcategory) async {
    final filtercategories = await productRepo.getfiltercategoryDatasource(subcategory);
    return filtercategories;
  }


  Future<DetailProduct> getDetailsProductDatasource(int id) async {
    final productdetails = await productData.getDetailsProduct(id);
    return productdetails;
  }
  Future <List<Product>>getSearchfromDtasource(String keyword) async {
    final season = await productRepo.getSearchfromDtasource(keyword);
    return season;
  }
}
