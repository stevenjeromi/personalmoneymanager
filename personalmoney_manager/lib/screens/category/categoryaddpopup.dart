import 'package:flutter/material.dart';
import 'package:personalmoney_manager/db/categorydb.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';
import 'package:personalmoney_manager/screens/category/category.dart';
import 'package:personalmoney_manager/db/categorydb.dart';

ValueNotifier<categorytype> selectedcategory =
    ValueNotifier(categorytype.income);

Future<void> showcategortasspopup(BuildContext context) async {
  final namedittingcontroller = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: namedittingcontroller,
              decoration: InputDecoration(
                hintText: 'Category name ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                radiobutton(title: 'Income', type: categorytype.income),
                radiobutton(title: 'Expense', type: categorytype.expense)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  final name = namedittingcontroller.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final type = selectedcategory.value;
                  final cat = categorymodel(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: name,
                      type: type);
                  categoryDB.instance.insertcategory(cat);
                  //categoryDB().insertcategory(cat);
                  Navigator.of(ctx).pop();
                },
                child: Text('add')),
          )
        ],
      );
    },
  );
}

class radiobutton extends StatelessWidget {
  final String title;
  final categorytype type;
  const radiobutton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedcategory,
            builder: (BuildContext ctx, categorytype newcategory, Widget? _) {
              return Radio<categorytype>(
                  value: type,
                  groupValue: newcategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedcategory.value = value;
                    selectedcategory.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
