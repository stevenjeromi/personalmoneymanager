import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';

const categoryDBname = 'catDB';

abstract class categorydbfunct {
  Future<List<categorymodel>> getCategories();
  Future<void> insertcategory(categorymodel value);
  Future<void> deletecategory(String categoryID);
}

class categoryDB implements categorydbfunct {
  categoryDB._internal();
  static categoryDB instance = categoryDB._internal();
  factory categoryDB() {
    return instance;
  }

  ValueNotifier<List<categorymodel>> incomecatlist = ValueNotifier([]);
  ValueNotifier<List<categorymodel>> expensecatlist = ValueNotifier([]);

  @override
  Future<void> insertcategory(categorymodel value) async {
    final categorydb = await Hive.openBox<categorymodel>(categoryDBname);
    await categorydb.put(value.id, value);
    refreshui();
  }

  @override
  Future<List<categorymodel>> getCategories() async {
    final categorydb = await Hive.openBox<categorymodel>(categoryDBname);
    return categorydb.values.toList();
  }

  Future<void> refreshui() async {
    final allcategories = await getCategories();
    incomecatlist.value.clear();
    expensecatlist.value.clear();
    Future.forEach(allcategories, (categorymodel cat) {
      if (cat.type == categorytype.income) {
        incomecatlist.value.add(cat);
      } else {
        expensecatlist.value.add(cat);
      }
    });
    incomecatlist.notifyListeners();
    expensecatlist.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryID) async {
    final categoryDB = await Hive.openBox<categorymodel>(categoryDBname);
    await categoryDB.delete(categoryID);
    refreshui();
  }
}
