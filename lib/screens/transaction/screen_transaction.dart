import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_project/db/transaction/transaction_db.dart';
import 'package:money_management_project/models/category/category_model.dart';

import '../../models/transactions/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    // getting transacations
    TransactionDB().transactionRefresher();

    return ValueListenableBuilder(
        valueListenable: transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _){
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final _transaction = newList[index];
                return Slidable(
                  key: Key(_transaction.id!),
                  startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                    children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDB().deleteTransaction(_transaction.id!);
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                  ),
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListTile(
                      title: Text('Rs ${_transaction.amount}',
                          style: const TextStyle(fontWeight: FontWeight.w500)
                      ),
                      subtitle: Text(_transaction.purpose),
                      leading: CircleAvatar(
                        backgroundColor: _transaction.category.type==CategoryType.income ? Colors.green : Colors.red,
                        radius: 50,
                        child: Text(parseDate(_transaction.date), style: const TextStyle(
                            fontWeight: FontWeight.w500
                        ),textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext ctx, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: newList.length);
        }
    );
  }

  String parseDate(DateTime date){
    final _date = DateFormat.MMMd().format(date);
    final _splittedDate = _date.split(' ');
    return '${_splittedDate[1]} \n ${_splittedDate[0]}';
  }
}
