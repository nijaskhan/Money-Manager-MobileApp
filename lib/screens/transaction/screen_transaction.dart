import 'package:flutter/material.dart';
import 'package:money_management_project/db/transaction/transaction_db.dart';

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
                print(_transaction.category);
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    title: Text('Rs ${_transaction.amount}',
                        style: TextStyle(fontWeight: FontWeight.w500)
                    ),
                    subtitle: Text('${_transaction.purpose}'),
                    leading: CircleAvatar(
                      radius: 50,
                      child: Text('12 \nJuly', style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),textAlign: TextAlign.center,),
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
}
