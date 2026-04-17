import 'package:isar/isar.dart';

part 'stock_item.g.dart';

@Collection()
class StockItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String sku;

  late String name;
  late String description;
  late int quantity;
  late String unit;
  late String location;

  @Index()
  late String barcode;

  late DateTime createdAt;
  late DateTime updatedAt;

  StockItem copyWith({
    String? sku,
    String? name,
    String? description,
    int? quantity,
    String? unit,
    String? location,
    String? barcode,
  }) {
    final item = StockItem()
      ..id = id
      ..sku = sku ?? this.sku
      ..name = name ?? this.name
      ..description = description ?? this.description
      ..quantity = quantity ?? this.quantity
      ..unit = unit ?? this.unit
      ..location = location ?? this.location
      ..barcode = barcode ?? this.barcode
      ..createdAt = createdAt
      ..updatedAt = DateTime.now();
    return item;
  }
}
