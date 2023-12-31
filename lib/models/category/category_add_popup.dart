import 'package:flutter/material.dart';
import 'package:money_management_project/db/category/category_db.dart';
import 'package:money_management_project/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

final _categoryNameTextController = TextEditingController();

Future<void> showCategoryAddPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(11))),
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: _categoryNameTextController,
                decoration: const InputDecoration(
                  hintText: 'category name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: ElevatedButton(
                  onPressed: () {
                    final _category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _categoryNameTextController.text,
                        type: selectedCategoryNotifier.value);
                    CategoryDB().insertCategory(_category);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.fixed,
                      duration: const Duration(seconds: 3),
                      content: Text(
                          '${_categoryNameTextController.text} added '
                          'as ${selectedCategoryNotifier.value == CategoryType.income ? "income" : "expense"}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.green.shade300,
                    ));
                    Navigator.of(ctx).pop();
                    _categoryNameTextController.text="";
                  },
                  child: const Text('add category')),
            )
          ],
        );
      });
}

// radioButton
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedCategoryNotifier,
        builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
          return Row(
            children: [
              Radio<CategoryType>(
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    selectedCategoryNotifier.notifyListeners();
                  }),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          );
        });
  }
}
