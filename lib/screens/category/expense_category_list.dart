import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              title: Text("expense category ${index+1}"),
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
      itemCount: 30,
    );
  }
}
