import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/models/category/category_model.dart';
import 'package:money_management_app/screens/category/category_add_popup.dart';
import 'package:money_management_app/screens/category/category_screen.dart';
import 'package:money_management_app/screens/transactions/add_transaction_screen.dart';
import 'package:money_management_app/screens/transactions/transaction_screen.dart';
import 'package:money_management_app/screens/widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final pages = const [TransactionScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Money Manager"),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyBottomNavigationBar(),
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, updatedIndex, child) {
          return pages[updatedIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndex.value == 0) {
            print("Transactions Floating....");
            Navigator.of(context).pushNamed(AddTransactionScreen.routename);
          } else {
            print("Category Floating...");
            showAddCategoryPopup(context);
            // final _sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(), 
            //   name: "Travel", 
            //   type: CategoryType.expense
            // );
            // CategoryDB().insetCategory(_sample);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
