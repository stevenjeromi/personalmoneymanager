import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:personalmoney_manager/db/categorydb.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';
import 'package:personalmoney_manager/models/transactions/transactionmodel.dart';
import 'package:personalmoney_manager/screens/transaction/transaction.dart';

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

  String? categoryid;
  final purposetexteditingcontroller = TextEditingController();
  final amounteditingcontroller = TextEditingController();

  @override
  void initState() {
    selectedcategorytype = categorytype.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          controller: purposetexteditingcontroller,
          decoration: InputDecoration(hintText: 'purpose'),
        ),
        TextFormField(
          controller: amounteditingcontroller,
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
                    groupValue: selectedcategorytype,
                    onChanged: (newvalue) {
                      setState(() {
                        selectedcategorytype = categorytype.income;
                        categoryid = null;
                      });
                    }),
                Text('Income'),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: categorytype.expense,
                    groupValue: selectedcategorytype,
                    onChanged: (newvalue) {
                      setState(() {
                        selectedcategorytype = categorytype.expense;
                        categoryid = null;
                      });
                    }),
                Text('Expense'),
              ],
            ),
          ],
        ),
        DropdownButton(
          hint: Text('Select category'),
          value: categoryid,
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
          items: (selectedcategorytype == categorytype.income
                  ? categoryDB().expensecatlist
                  : categoryDB().incomecatlist)
              .value
              .map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: Text(e.name),
              onTap: () {
                selectedcategorymodel = e;
              },
            );
          }).toList(),
          onChanged: (selectedvalue) {
            categoryid = selectedvalue;
          },
        ),
        ElevatedButton.icon(
            onPressed: () {
              addTransaction();
            },
            icon: Icon(Icons.check),
            label: Text('Submit'))
      ]),
    )));
  }

  Future<void> addTransaction() async {
    final purposetext = purposetexteditingcontroller.text;
    final amount = amounteditingcontroller.text;

    if (purposetext.isEmpty) {
      return;
    }
    if (amount.isEmpty) {
      return;
    }
    if (categoryid == null) {
      return;
    }
    if (selectedcategorymodel == null) {
      return;
    }
    if (selectdate == null) {
      return;
    }
    final parseamount = double.tryParse(amount);
    if (parseamount == null) {
      return;
    }
    Transaction(
        purpose: purposetext,
        amount: parseamount,
        date: selectdate!,
        type: selectedcategorytype!,
        category: selectedcategorymodel!);
  }
}
