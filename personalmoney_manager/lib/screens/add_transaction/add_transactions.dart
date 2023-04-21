import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:personalmoney_manager/db/categorydb.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';

class screentransaction extends StatefulWidget {
  static const routename = 'add-transactions';
  const screentransaction({super.key});

  @override
  State<screentransaction> createState() => _screentransactionState();
}

class _screentransactionState extends State<screentransaction> {
  DateTime? selectdate;
  categorytype? selectedcategorytype;
  categorymodel? selectedcategorymodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'purpose'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'amount'),
        ),
        TextButton.icon(
            onPressed: () async {
              final selectdatetemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 30)),
                  lastDate: DateTime.now());
              if (selectdatetemp == null) {
                return;
              } else {
                setState(() {
                  selectdate = selectdatetemp;
                });
              }
            },
            icon: Icon(Icons.calendar_today),
            label: Text(
                selectdate == null ? 'selectdate' : selectdate.toString())),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Radio(
                    value: categorytype.income,
                    groupValue: categorytype.income,
                    onChanged: (newvalue) {}),
                Text('Income'),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: categorytype.expense,
                    groupValue: categorytype.expense,
                    onChanged: (newvalue) {}),
                Text('Expense'),
              ],
            ),
          ],
        ),
        DropdownButton(
          hint: Text('Select category'),
          /*items: [
                DropdownMenuItem(
                  child: Text('Category 1'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('Category 2'),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text('Category 3'),
                  value: 3,
                ),
              ],
              
            )*/
          items: categoryDB().expensecatlist.value.map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: Text(e.name),
            );
          }).toList(),
          onChanged: (selectedvalue) {
            print(selectedvalue);
          },
        ),
        ElevatedButton.icon(
            onPressed: () {}, icon: Icon(Icons.check), label: Text('Submit'))
      ]),
    )));
  }
}
