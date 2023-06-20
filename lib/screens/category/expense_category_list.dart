import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseNotifierListener,
      builder: (context, List<CategoryModel> value, child) {
        return ListView.separated(
        itemBuilder: (context, index) {
        final category = value[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(category.name),
              trailing: IconButton(onPressed: () {
                CategoryDB.instance.deleteCategory(category.id);
              }, icon: const Icon(Icons.delete)),
            ),
          );
        },
        separatorBuilder: ((contect, index) => const SizedBox(
          height: 10,
        )),
        itemCount: value.length);
      },
    );
  }
}
