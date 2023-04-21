import 'package:hive_flutter/adapters.dart';
import 'package:personalmoney_manager/models/category/categorymodel.dart';
part 'transactionmodel.g.dart';

@HiveType(typeId: 2)
class Transaction {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final categorytype type;
  @HiveField(4)
  final categorymodel category;
  @HiveField(5)
  String? id;

  Transaction(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category}) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
