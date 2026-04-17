import 'package:isar/isar.dart';
import 'invoice_line_item.dart';

part 'invoice.g.dart';

enum InvoiceStatus { draft, issued }

@Collection()
class Invoice {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String invoiceNumber;

  late String customerName;
  late String customerAddress;
  late List<InvoiceLineItem> lineItems;
  late DateTime issuedAt;
  late double totalAmount;
  late String currency;
  late int createdByUserId;

  @Enumerated(EnumType.name)
  late InvoiceStatus status;

  Invoice copyWith({
    String? customerName,
    String? customerAddress,
    List<InvoiceLineItem>? lineItems,
    double? totalAmount,
    String? currency,
    InvoiceStatus? status,
  }) {
    final inv = Invoice()
      ..id = id
      ..invoiceNumber = invoiceNumber
      ..customerName = customerName ?? this.customerName
      ..customerAddress = customerAddress ?? this.customerAddress
      ..lineItems = lineItems ?? this.lineItems
      ..issuedAt = issuedAt
      ..totalAmount = totalAmount ?? this.totalAmount
      ..currency = currency ?? this.currency
      ..createdByUserId = createdByUserId
      ..status = status ?? this.status;
    return inv;
  }
}
