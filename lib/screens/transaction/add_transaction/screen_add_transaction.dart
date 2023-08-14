import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:money_management_project/db/category/category_db.dart';
import 'package:money_management_project/db/transaction/transaction_db.dart';
import 'package:money_management_project/models/category/category_model.dart';
import 'package:money_management_project/models/transactions/transaction_model.dart';

// ignore: camel_case_types
class ScreenAddTransactions extends StatefulWidget {
  const ScreenAddTransactions({super.key});

  static const routeName = 'screenAddTransactionRoute';

  @override
  State<ScreenAddTransactions> createState() => _ScreenAddTransactionsState();
}

class _ScreenAddTransactionsState extends State<ScreenAddTransactions> {
  String? _selectedCategory;
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  final _purposeTextEdit = TextEditingController();
  final _amountTextEdit = TextEditingController();

  bool validationBool = false;
/*
  purpose
  Date
  Amount
  Income/Expense
  Category Type
*/

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
              child: Text(
                'Add Transaction',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _purposeTextEdit,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'purpose',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _amountTextEdit,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
                hintText: 'amount',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.date_range),
                label: Text(_selectedDate == null
                    ? 'pick the date'
                    : _selectedDate.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      onChanged: (selectedCategoryType) {
                        setState(() {
                          _selectedCategoryType = selectedCategoryType;
                          _selectedCategory = null;
                        });
                      }),
                  const Text('Income')
                ]),
                Row(children: [
                  Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (selectedCategoryType) {
                        setState(() {
                          _selectedCategoryType = selectedCategoryType;
                          _selectedCategory = null;
                        });
                      }),
                  const Text('Expense')
                ])
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: DropdownButton(
                  hint: const Text('select Category'),
                  value: _selectedCategory,
                  items: (_selectedCategoryType == CategoryType.income
                          ? incomeCategoryListListener
                          : expenseCategoryListListener)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: (){
                        _selectedCategoryModel=e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedCategory) {
                    if (selectedCategory == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = selectedCategory;
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
                Center(
                  child: validationBool == true
                      ? const Text(
                    "all fields required",
                    style: TextStyle(color: Colors.red),
                  )
                      : const Text(""),
                ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    addTransaction();
                  },
                  child: const Text('submit')),
            ),
          ]),
        ),
      ),
    );
  }

  void addTransaction() {
    final _purpose = _purposeTextEdit.text;
    final _amount = _amountTextEdit.text;
    final _parsedAmount = double.tryParse(_amount);

    // validation
    if (_parsedAmount == null) {
      setState(() {
        validationBool = true;
      });
      return;
    }
    if (_purpose == null) {
      setState(() {
        validationBool = true;
      });
      return;
    }
    if(_selectedDate==null){
      setState(() {
        validationBool = true;
      });
      return;
    }
    if(_selectedCategory==null){
      setState(() {
        validationBool = true;
      });
      return;
    }
    if(_selectedCategoryModel==null){
      return;
    }

    final _transaction = TransactionModel(
        purpose: _purpose,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!
    );
    
    TransactionDB().addTransaction(_transaction);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: Text("Trasaction added",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.green.shade300,
    ));

    Navigator.of(context).pop();

    setState(() {
      validationBool=false;
    });
  }
}
