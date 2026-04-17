import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:wms_pro/core/constants/app_routes.dart';
import 'package:wms_pro/features/auth/presentation/auth_controller.dart';
import 'package:wms_pro/features/invoices/data/invoice_repository.dart';
import 'package:wms_pro/features/invoices/domain/invoice.dart';
import 'package:wms_pro/features/invoices/domain/invoice_line_item.dart';
import 'package:wms_pro/features/inventory/data/inventory_repository.dart';
import '../service/invoice_pdf_service.dart';

class InvoiceController extends GetxController {
  final InvoiceRepository repository;
  final InventoryRepository inventoryRepo;

  InvoiceController({
    required this.repository,
    required this.inventoryRepo,
  });

  final RxList<Invoice> invoices = <Invoice>[].obs;
  final RxList<InvoiceLineItem> lineItems = <InvoiceLineItem>[].obs;
  final Rxn<Invoice> selectedInvoice = Rxn<Invoice>();
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final customerNameController = TextEditingController();
  final customerAddressController = TextEditingController();
  final currencyController = TextEditingController(text: 'EUR');

  @override
  void onReady() {
    super.onReady();
    loadInvoices();
  }

  @override
  void onClose() {
    customerNameController.dispose();
    customerAddressController.dispose();
    currencyController.dispose();
    super.onClose();
  }

  Future<void> loadInvoices() async {
    isLoading.value = true;
    error.value = null;
    try {
      invoices.value = await repository.getAll();
    } catch (e) {
      error.value = 'Failed to load invoices';
    } finally {
      isLoading.value = false;
    }
  }

  void openCreate() {
    selectedInvoice.value = null;
    lineItems.clear();
    customerNameController.clear();
    customerAddressController.clear();
    currencyController.text = 'EUR';
    Get.toNamed(AppRoutes.invoiceDetail);
  }

  void openView(Invoice invoice) {
    selectedInvoice.value = invoice;
    customerNameController.text = invoice.customerName;
    customerAddressController.text = invoice.customerAddress;
    currencyController.text = invoice.currency;
    lineItems.value = List.from(invoice.lineItems);
    Get.toNamed(AppRoutes.invoiceDetail);
  }

  void addLineItem(InvoiceLineItem item) => lineItems.add(item);

  void removeLineItem(int index) => lineItems.removeAt(index);

  double get total =>
      lineItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  Future<void> save({required InvoiceStatus status}) async {
    if (customerNameController.text.trim().isEmpty) {
      error.value = 'Customer name is required';
      return;
    }
    if (lineItems.isEmpty) {
      error.value = 'Add at least one line item';
      return;
    }
    isLoading.value = true;
    error.value = null;
    try {
      final authCtrl = Get.find<AuthController>();
      final existing = selectedInvoice.value;
      final invoice = Invoice()
        ..id = existing?.id ?? -1
        ..invoiceNumber = existing?.invoiceNumber ??
            await repository.nextInvoiceNumber()
        ..customerName = customerNameController.text.trim()
        ..customerAddress = customerAddressController.text.trim()
        ..lineItems = lineItems.toList()
        ..issuedAt = existing?.issuedAt ?? DateTime.now()
        ..totalAmount = total
        ..currency = currencyController.text.trim()
        ..createdByUserId = authCtrl.currentUser.value?.id ?? 0
        ..status = status;
      if (existing != null) invoice.id = existing.id;
      await repository.save(invoice);
      await loadInvoices();
      Get.back();
    } catch (e) {
      error.value = 'Failed to save invoice';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> shareAsPdf(Invoice invoice) async {
    try {
      final pdf = await InvoicePdfService.build(invoice);
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: '${invoice.invoiceNumber}.pdf',
      );
    } catch (e) {
      error.value = 'Failed to generate PDF';
    }
  }

  Future<void> delete(int id) async {
    try {
      await repository.delete(id);
      await loadInvoices();
    } catch (e) {
      error.value = 'Failed to delete invoice';
    }
  }
}
