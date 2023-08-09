import 'package:hive_flutter/adapters.dart';
import 'package:money_management_project/models/category/category_model.dart';

const categoryDbName = 'category-database';

abstract class CategoryDbFunc {

  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunc{
  @override
  Future<void> insertCategory(CategoryModel value) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    _categoryDB.add(value);
  }
}