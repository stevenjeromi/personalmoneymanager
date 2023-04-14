import 'package:hive_flutter/adapters.dart';
part 'categorymodel.g.dart';

@HiveType(typeId: 2)
enum categorytype {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class categorymodel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isdeleted;
  @HiveField(3)
  final categorytype type;

  categorymodel(
      {required this.id,
      required this.name,
      this.isdeleted = false,
      required this.type});

  @override
  String toString() {
    return '{$name $type}';
  }
}
