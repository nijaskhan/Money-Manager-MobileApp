import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_project/models/category/category_model.dart';

const categoryDbName = 'category-database';

ValueNotifier<List<CategoryModel>> incomeCategoryListListener = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> expenseCategoryListListener = ValueNotifier([]);

abstract class CategoryDbFunc {

  Future<void> insertCategory(CategoryModel value);
  Future<List<CategoryModel>> getCategories();
}

class CategoryDB implements CategoryDbFunc{
  // creating a single object for all instance from this class
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB(){
    return instance;
  }

  @override
  Future<void> insertCategory(CategoryModel value) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    // _categoryDB.add(value);  the id is auto-adding in this line
    _categoryDB.put(value.id, value);   //we are setting the id as our given id from value.id
    refreshCategoryUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    return _categoryDB.values.toList();
  }

  @override
  Future<void> refreshCategoryUI() async{
    final _allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();

    await Future.forEach(_allCategories, (CategoryModel category) {
      if(category.type == CategoryType.income){
        incomeCategoryListListener.value.add(category);
      }else{
        expenseCategoryListListener.value.add(category);
      }
    });

    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String id) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryDbName);
    _categoryDB.delete(id);
    refreshCategoryUI();
  }
}