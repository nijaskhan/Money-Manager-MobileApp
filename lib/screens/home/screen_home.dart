import 'package:flutter/material.dart';
import 'package:money_management_project/screens/category/screen_category.dart';
import 'package:money_management_project/screens/home/widgets/widget_botttom_navbar.dart';
import 'package:money_management_project/screens/transaction/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    const ScreenTransaction(),
    const ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MoneyManagerBotttomNavigation(),
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade300,
          title: const Text(
            'Money Manager',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/images/logo.png'),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext ctx, int updatedIndex, Widget? _) {
              return _pages[updatedIndex];
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            selectedIndexNotifier.value == 0
                ? print("transaction page")
                : print("category page");
          },
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.add),
        ));
  }
}
