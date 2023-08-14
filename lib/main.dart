import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_project/models/category/category_model.dart';
import 'package:money_management_project/models/transactions/transaction_model.dart';
import 'package:money_management_project/screens/home/screen_home.dart';
import 'package:money_management_project/screens/transaction/add_transaction/screen_add_transaction.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management Application',
      theme: ThemeData(primaryColor: Colors.purpleAccent.shade200),
      home: ScreenHome(),
      routes: {
        ScreenAddTransactions.routeName: (ctx) => const ScreenAddTransactions(),
      },
    );
  }
}
