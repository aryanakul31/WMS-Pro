import 'package:isar/isar.dart';

part 'invoice_line_item.g.dart';

@Embedded()
class InvoiceLineItem {
  late String itemId;
  late String sku;
  late String name;
  late double unitPrice;
  late int quantity;
  late double totalPrice;
}
