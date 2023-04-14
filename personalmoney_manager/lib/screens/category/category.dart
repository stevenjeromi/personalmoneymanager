import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:personalmoney_manager/db/categorydb.dart';
import 'package:personalmoney_manager/screens/category/expensecat.dart';
import 'package:personalmoney_manager/screens/category/incomecat.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category>
    with SingleTickerProviderStateMixin {
  late TabController tabcont;

  @override
  void initState() {
    tabcont = TabController(length: 2, vsync: this);
    categoryDB().refreshui();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: tabcont,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.blueGrey,
            tabs: const [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENSE',
              ),
            ]),
        Expanded(
          child: TabBarView(
            controller: tabcont,
            children: const [
              incomecat(),
              expensecat(),
            ],
          ),
        )
      ],
    );
  }
}
