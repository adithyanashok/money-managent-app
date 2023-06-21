import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transactions/transaction_db.dart';
import 'package:money_management_app/models/category/category_model.dart';
import 'package:money_management_app/models/transaction/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});
  static const routename = 'add-transaction';

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime? _selectedDateTme;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _purposeEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // purpose
            TextFormField(
              controller: _purposeEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Enter purpose")),
            ),
            const SizedBox(
              height: 20,
            ),
            // amount
            TextFormField(
              controller: _amountEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Enter amount")),
            ),
            // date button

            TextButton.icon(
                onPressed: () async {
                  final _date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (_date == null) {
                    return;
                  }
                  print(_date);
                  setState(() {
                    _selectedDateTme = _date;
                  });
                },
                icon: const Icon(Icons.calendar_month_rounded),
                label: Text(_selectedDateTme == null
                    ? "Select Date"
                    : _selectedDateTme.toString())),
            // Radio button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _categoryID = null;
                            _selectedCategoryType = CategoryType.income;
                          });
                        }),
                    const Text("Income")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        }),
                    const Text("Expense")
                  ],
                )
              ],
            ),
            // category type
            DropdownButton<String>(
                hint: const Text("Select Category"),
                value: _categoryID,
                items: (_selectedCategoryType == CategoryType.income
                        ? CategoryDB.instance.incomeNotifierListener
                        : CategoryDB.instance.expenseNotifierListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _categoryID = newValue;
                  });
                }),
            ElevatedButton(onPressed: () {
              addTransaction();
            }, child: const Text("Submit"))
          ],
        ),
      ),
    ));
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeEditingController.text;
    final _amountText = _amountEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDateTme == null) {
      return;
    }
    if(_selectedCategoryType == null){
      return;
    }
    if(_selectedCategoryModel == null){
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    final _transaction = TransactionModel(
        purpose: _purposeText,
        amount: _parsedAmount,
        date: _selectedDateTme!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!
    );
    print(_transaction);

    await TransactionDB.instance.addTransaction(_transaction);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
