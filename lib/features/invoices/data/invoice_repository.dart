import 'package:isar/isar.dart';
import '../domain/invoice.dart';
import 'package:wms_pro/core/constants/app_constants.dart';

abstract class InvoiceRepository {
  Future<List<Invoice>> getAll();
  Future<Invoice?> getById(int id);
  Future<void> save(Invoice invoice);
  Future<void> delete(int id);
  Future<String> nextInvoiceNumber();
}

class LocalInvoiceRepository implements InvoiceRepository {
  final Isar isar;
  LocalInvoiceRepository({required this.isar});

  @override
  Future<List<Invoice>> getAll() =>
      isar.invoices.where().sortByIssuedAtDesc().findAll();

  @override
  Future<Invoice?> getById(int id) => isar.invoices.get(id);

  @override
  Future<void> save(Invoice invoice) =>
      isar.writeTxn(() => isar.invoices.put(invoice));

  @override
  Future<void> delete(int id) =>
      isar.writeTxn(() => isar.invoices.delete(id));

  @override
  Future<String> nextInvoiceNumber() async {
    final count = await isar.invoices.count();
    final seq = (count + 1).toString().padLeft(4, '0');
    return '${AppConstants.invoiceNumberPrefix}-$seq';
  }
}
