import 'package:isar/isar.dart';
import '../domain/stock_item.dart';

abstract class InventoryRepository {
  Future<List<StockItem>> getAll();
  Future<StockItem?> getById(int id);
  Future<StockItem?> getByBarcode(String barcode);
  Future<void> save(StockItem item);
  Future<void> delete(int id);
  Future<int> totalCount();
}

class LocalInventoryRepository implements InventoryRepository {
  final Isar isar;
  LocalInventoryRepository({required this.isar});

  @override
  Future<List<StockItem>> getAll() =>
      isar.stockItems.where().sortByNameDesc().findAll();

  @override
  Future<StockItem?> getById(int id) => isar.stockItems.get(id);

  @override
  Future<StockItem?> getByBarcode(String barcode) =>
      isar.stockItems.filter().barcodeEqualTo(barcode).findFirst();

  @override
  Future<void> save(StockItem item) =>
      isar.writeTxn(() => isar.stockItems.put(item));

  @override
  Future<void> delete(int id) =>
      isar.writeTxn(() => isar.stockItems.delete(id));

  @override
  Future<int> totalCount() => isar.stockItems.count();
}
