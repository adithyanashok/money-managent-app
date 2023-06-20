import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeNotifierListener, 
      builder: (context, value, child) {
        return ListView.separated(
        itemBuilder: (context, index) {
          final category = value[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
              title: Text(category.name),
              trailing: IconButton(
                onPressed: () {
                  CategoryDB.instance.deleteCategory(category.id);
                },
                icon: const Icon(Icons.delete)),
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
