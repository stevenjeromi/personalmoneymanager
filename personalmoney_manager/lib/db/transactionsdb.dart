import 'package:hive_flutter/adapters.dart';
import 'package:personalmoney_manager/screens/transaction/transaction.dart';
import 'package:personalmoney_manager/models/transactions/transactionmodel.dart';

const transation_db_name = 'transaction_db';

abstract class transactiondbfunctions {
  Future<void> addtransaction(transaction obj);
}

class transactiondb implements transactiondbfunctions {
  @override
  Future<void> addtransaction(transaction obj) async {
    final db = await Hive.openBox<transaction>(transation_db_name);
    await db.put(obj.id, obj);
  }
}
