import 'package:flutter/material.dart';
import 'package:money_management_app/screens/category/category_screen.dart';
import 'package:money_management_app/screens/transactions/transaction_screen.dart';
import 'package:money_management_app/screens/widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final pages = const [TransactionScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Money Manager")),
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
          } else {
            print("Category Floating...");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
