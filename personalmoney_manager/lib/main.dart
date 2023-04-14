import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';
import 'package:personalmoney_manager/screens/category/category.dart';
import 'package:personalmoney_manager/screens/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (Hive.isAdapterRegistered(categorytypeAdapter().typeId)) {
    Hive.registerAdapter(categorytypeAdapter());
  }

  if (Hive.isAdapterRegistered(categorymodelAdapter().typeId)) {
    Hive.registerAdapter(categorymodelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const home(),
    );
  }
}
