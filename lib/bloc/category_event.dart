part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {}

class LoadSubCategories extends CategoryEvent {
  final int id;
  LoadSubCategories(this.id);

}

class LoadBanners extends CategoryEvent{
  final int id;
  LoadBanners(this.id);

}
