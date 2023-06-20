import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);

Future<void> showAddCategoryPopup(BuildContext context) async {
  final textEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: ((ctx) {
        return SimpleDialog(
          title: const Text("Add Category"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                    hintText: "Enter category name",
                    border: OutlineInputBorder()),
              ),
            ),
            Row(
              children: [
                RadioButton(title: "Income", type: CategoryType.income),
                RadioButton(title: "Expense", type: CategoryType.expense)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = textEditingController.text;
                  if(_name.isEmpty){
                    return;
                  }
                  final _type = selectedCategoryNotifier.value;
                  final _category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type
                  );

                  CategoryDB.instance.insetCategory(_category);
                  Navigator.of(ctx).pop();

                },
                 child: const Text("Add")),
            )
          ],
        );
      }));
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  // final CategoryType selectedType;
  RadioButton({super.key, required this.title, required this.type});

  CategoryType? _type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (context, value, child) {
          return Radio<CategoryType>(
            value: type,
            groupValue: selectedCategoryNotifier.value,
            onChanged: (value) {
              if(value == null){
                return;
              }
              selectedCategoryNotifier.value = value;
              selectedCategoryNotifier.notifyListeners();
            });
        },),
        Text(title)
      ]
    );
  }
}
