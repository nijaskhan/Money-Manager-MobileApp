import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_project/models/transactions/transaction_model.dart';

const transactionDbName = 'transaction-database';

ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

abstract class TransactionDbFunc{
  Future<void>addTransaction(TransactionModel value);
  Future<List<TransactionModel>>getTransaction();
//   implement the abstract class and write the function
}

class TransactionDB implements TransactionDbFunc{

  static final TransactionDB _instance = TransactionDB._internal();
  factory TransactionDB(){
    return _instance;
  }
  TransactionDB._internal();

  Future<void> transactionRefresher() async{
    final _list = await getTransaction();
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> addTransaction(TransactionModel value) async{
    final _db = await Hive.openBox<TransactionModel>(transactionDbName);
    await _db.put(value.id, value);
  }

  @override
  Future<List<TransactionModel>>getTransaction() async{
    final _db = await Hive.openBox<TransactionModel>(transactionDbName);
    return _db.values.toList();
  }
}
