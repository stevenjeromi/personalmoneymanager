import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:personalmoney_manager/db/categorydb.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';

class incomecat extends StatelessWidget {
  const incomecat({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryDB().incomecatlist,
        builder: (BuildContext ctx, List<categorymodel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = newlist[index];
                return Card(
                  color: Colors.lime,
                  elevation: 5,
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 10);
              },
              itemCount: newlist.length);
        });
  }
}
