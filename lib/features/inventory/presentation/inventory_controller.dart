import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/constants/app_routes.dart';
import 'package:wms_pro/features/inventory/data/inventory_repository.dart';
import 'package:wms_pro/features/inventory/domain/stock_item.dart';

class InventoryController extends GetxController {
  final InventoryRepository repository;
  InventoryController({required this.repository});

  final RxList<StockItem> items = <StockItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final Rxn<StockItem> selectedItem = Rxn<StockItem>();

  final skuController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final locationController = TextEditingController();
  final barcodeController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    loadItems();
  }

  @override
  void onClose() {
    skuController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    unitController.dispose();
    locationController.dispose();
    barcodeController.dispose();
    super.onClose();
  }

  Future<void> loadItems() async {
    isLoading.value = true;
    error.value = null;
    try {
      items.value = await repository.getAll();
    } catch (e) {
      error.value = 'Failed to load items';
    } finally {
      isLoading.value = false;
    }
  }

  void openAdd() {
    selectedItem.value = null;
    _clearForm();
    Get.toNamed(AppRoutes.itemDetail);
  }

  void openEdit(StockItem item) {
    selectedItem.value = item;
    skuController.text = item.sku;
    nameController.text = item.name;
    descriptionController.text = item.description;
    quantityController.text = item.quantity.toString();
    unitController.text = item.unit;
    locationController.text = item.location;
    barcodeController.text = item.barcode;
    Get.toNamed(AppRoutes.itemDetail);
  }

  Future<void> save() async {
    final sku = skuController.text.trim();
    final name = nameController.text.trim();
    final qty = int.tryParse(quantityController.text.trim()) ?? 0;
    if (sku.isEmpty || name.isEmpty) {
      error.value = 'SKU and name are required';
      return;
    }
    isLoading.value = true;
    error.value = null;
    try {
      final existing = selectedItem.value;
      final now = DateTime.now();
      final item = StockItem()
        ..id = existing?.id ?? -1
        ..sku = sku
        ..name = name
        ..description = descriptionController.text.trim()
        ..quantity = qty
        ..unit = unitController.text.trim()
        ..location = locationController.text.trim()
        ..barcode = barcodeController.text.trim()
        ..createdAt = existing?.createdAt ?? now
        ..updatedAt = now;
      if (existing != null) item.id = existing.id;
      await repository.save(item);
      await loadItems();
      Get.back();
    } catch (e) {
      error.value = 'Failed to save item';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> delete(int id) async {
    try {
      await repository.delete(id);
      await loadItems();
    } catch (e) {
      error.value = 'Failed to delete item';
    }
  }

  void _clearForm() {
    skuController.clear();
    nameController.clear();
    descriptionController.clear();
    quantityController.clear();
    unitController.clear();
    locationController.clear();
    barcodeController.clear();
  }
}
