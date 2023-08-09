import 'package:flutter/material.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void initState(){
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
        labelColor: Colors.black,
        indicatorColor: Colors.indigo,
        controller: _tabController,
        tabs: [
          Tab(text: 'INCOME'),
          Tab(text: 'EXPENSE')
        ],
      ),
    ]);
  }
}
