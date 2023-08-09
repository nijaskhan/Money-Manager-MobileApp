import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: ListView.separated(
          itemBuilder: (ctx, index) {
            return const Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ListTile(
                title: Text(
                  'Rs 10000',
                  style: TextStyle(fontWeight: FontWeight.w500)
                ),
                subtitle: Text('Food'),
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
          itemCount: 30),
    ));
  }
}
