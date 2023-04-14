import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:personalmoney_manager/screens/home/home.dart';

class bottom_navigation extends StatelessWidget {
  const bottom_navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: home.selected,
      builder: (BuildContext ctx, int updatedindex, Widget? _) {
        return BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          currentIndex: updatedindex,
          onTap: (newindex) {
            home.selected.value = newindex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Transactions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories')
          ],
        );
      },
    );
  }
}
