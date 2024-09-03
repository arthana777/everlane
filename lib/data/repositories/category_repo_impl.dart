import 'package:everlane/domain/entities/category_entity.dart';
import 'package:everlane/repository/category_repo.dart';

import '../datasources/category_remote_datasources.dart';

class CategoryRepoImplementation implements CategoryRepo {
  final CategoryRemoteDataSource remoteDataSource = CategoryRemoteDataSourceImpl();

  @override
  Future<List<CategoryEntity>> getCategoryFromDataSource() async {
    try {
      final categoryModels = await remoteDataSource.getCategoryFromApi();
      return categoryModels.map((model) => CategoryEntity(name: model.name, id: model.id)).toList();
    } catch (e) {
      rethrow;
    }
  }
  Future<List<CategoryEntity>> getSubCategoryFromDataSource(int id) async {
    try {
      final subcategories = await remoteDataSource.getSubCategoryFromApi(id);
      return subcategories.map((model) => CategoryEntity(name: model.name, id: model.id,image: model.image)).toList();
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<List<CategoryEntity>> getBannersFromDatasource(int id)async {
    try {
      final banners = await remoteDataSource.getBanner(id);
      return banners.map((model) => CategoryEntity(name: model.name, id: model.id,image: model.image)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
