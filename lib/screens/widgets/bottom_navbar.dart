import 'package:flutter/material.dart';
import 'package:money_management_app/screens/home/home_screen.dart';

class MoneyBottomNavigationBar extends StatelessWidget {
  const MoneyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndex,
      builder: (context, updatedIndex, child) {
        return BottomNavigationBar(
        currentIndex: updatedIndex,
        onTap: (newIndex) {
          HomeScreen.selectedIndex.value = newIndex;
        },
        items: const [
        BottomNavigationBarItem(label: "Transactions", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Category", icon: Icon(Icons.category)),
      ]);
      },
    );
  }
}