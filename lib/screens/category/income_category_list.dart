import 'package:flutter/material.dart';
import 'package:money_management_project/db/category/category_db.dart';

import '../../models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: incomeCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final category = newList[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                child: Card(
                  elevation: 1,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(onPressed: (){
                      print("delete button pressed");
                    }, icon: const Icon(Icons.delete)),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index){
              return const SizedBox(height: 0,);
            },
            itemCount: newList.length,
          );

        }
    );
  }
}
