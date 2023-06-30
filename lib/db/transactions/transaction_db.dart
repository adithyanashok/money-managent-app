import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/transaction/transaction_model.dart';
import 'package:flutter/foundation.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> getTransaction();
  Future<void> addTransaction(TransactionModel transactionModel);
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel value) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await _db.put(value.id, value);
  }

  Future<void> refresh() async {
    final _list = await getTransaction();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final _transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDb.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String id) async{
    final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _transactionDb.delete(id);
    refresh();
  }
}
