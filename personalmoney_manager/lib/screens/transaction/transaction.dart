import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class transaction extends StatelessWidget {
  const transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              color: Color.fromARGB(255, 101, 184, 189),
              shadowColor: Colors.black,
              child: ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: CircleAvatar(
                  child: Text('10\noct 23'),
                  radius: 50,
                ),
                title: Text('Rs: 50000'),
                subtitle: Text('shopping'),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: 10),
    );
  }
}
