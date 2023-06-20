import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Text(
                  "12\nJun",
                  textAlign: TextAlign.center,
                ),
              ),
              title: Text("1000"),
              subtitle: Text("Income"),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
