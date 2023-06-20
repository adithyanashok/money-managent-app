import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/category/category_model.dart';

const CATEGORY_DB = 'category-db';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategory();
  Future<void> insetCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryId);
}

class CategoryDB implements CategoryDbFunctions {

  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB(){
    return instance;
  }


  ValueNotifier<List<CategoryModel>> incomeNotifierListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseNotifierListener = ValueNotifier([]);

  @override
  Future<void> insetCategory(CategoryModel value) async {
    final _category_db = await Hive.openBox<CategoryModel>(CATEGORY_DB);
    await _category_db.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final _category_db = await Hive.openBox<CategoryModel>(CATEGORY_DB);
    return _category_db.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategory();
    incomeNotifierListener.value.clear();
    expenseNotifierListener.value.clear();
    await Future.forEach(_allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeNotifierListener.value.add(category);
      } else {
        expenseNotifierListener.value.add(category);
      }
    });
    incomeNotifierListener.notifyListeners();
    expenseNotifierListener.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryId) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB);
    await _categoryDB.delete(categoryId);
    refreshUI();
  }
}
