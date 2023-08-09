import 'package:flutter/material.dart';
import 'package:money_management_project/screens/category/expense_category_list.dart';
import 'package:money_management_project/screens/category/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
        labelColor: Colors.black,
        indicatorColor: Colors.indigo,
        controller: _tabController,
        tabs: const [Tab(text: 'INCOME',), Tab(text: 'EXPENSE')],
      ),
      Expanded(
        child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeCategoryList(),
              ExpenseCategoryList(),
            ]),
      ),
    ]);
  }
}
