



import '../data/models/product_model.dart';


abstract class ProductRepo {
  Future<List<Product>> getProductFromDataSource();
  Future<List<Product>> getSeasonsfromDatasource(String seasons);
  Future<List<Product>> getfiltercategoryDatasource(int subcategory);
  // Future<DetailProduct> getDetailsProductDatasource(int id);
  Future<List<Product>> getSearchfromDtasource(String keyword);

}
