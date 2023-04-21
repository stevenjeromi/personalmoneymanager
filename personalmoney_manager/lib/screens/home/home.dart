import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:personalmoney_manager/db/categorydb.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';
import 'package:personalmoney_manager/screens/category/category.dart';
import 'package:personalmoney_manager/screens/category/categoryaddpopup.dart';
import 'package:personalmoney_manager/screens/home/widgets/bottom_navigation.dart';
import 'package:personalmoney_manager/screens/transaction/transaction.dart';

class home extends StatelessWidget {
  const home({super.key});

  static ValueNotifier<int> selected = ValueNotifier(1);
  final pages = const [
    transaction(),
    category(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MONEY MANAGER'),
          centerTitle: true,
        ),
        bottomNavigationBar: bottom_navigation(),
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: selected,
          builder: (BuildContext context, int updatedindex, _) {
            return pages[updatedindex];
          },
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selected.value == 0) {
              Navigator.of(context).pushNamed('add_transactions');
            } else {
              showcategortasspopup(context);

              /*final sample = categorymodel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: 'travel',
                  type: categorytype.expense);
              categoryDB().insertcategory(sample);*/
            }
          },
          child: Icon(Icons.add),
        ));
  }
}
