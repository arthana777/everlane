


import 'package:everlane/domain/entities/product_entity.dart';

import '../data/models/detailproduct.dart';
import '../data/models/product_model.dart';
import '../domain/entities/category_entity.dart';


abstract class ProductRepo {
  Future<List<Product>> getProductFromDataSource();
  Future<List<Product>> getSeasonsfromDatasource(String seasons);
  Future<List<Product>> getfiltercategoryDatasource(int subcategory);
  // Future<DetailProduct> getDetailsProductDatasource(int id);
  Future<List<Product>> getSearchfromDtasource(String keyword);

}
