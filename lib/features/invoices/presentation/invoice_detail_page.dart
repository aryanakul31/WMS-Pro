import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/invoices/domain/invoice.dart';
import 'package:wms_pro/features/invoices/domain/invoice_line_item.dart';
import 'invoice_controller.dart';

class InvoiceDetailPage extends GetView<InvoiceController> {
  const InvoiceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isView = controller.selectedInvoice.value != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isView
            ? controller.selectedInvoice.value!.invoiceNumber
            : 'New Invoice'),
        actions: [
          if (isView)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => controller
                  .shareAsPdf(controller.selectedInvoice.value!),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.customerNameController,
              style: AppTextStyles.bodyLarge,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller.customerAddressController,
              style: AppTextStyles.bodyLarge,
              maxLines: 2,
              decoration:
                  const InputDecoration(labelText: 'Customer Address'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller.currencyController,
              style: AppTextStyles.bodyLarge,
              decoration: const InputDecoration(labelText: 'Currency'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Line Items', style: AppTextStyles.heading3),
                TextButton.icon(
                  onPressed: () => _showAddLineItemDialog(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (controller.lineItems.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('No line items',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.disabled)),
                );
              }
              return Column(
                children: [
                  ...controller.lineItems.asMap().entries.map((e) {
                    final item = e.value;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.name, style: AppTextStyles.bodyMedium),
                      subtitle: Text(
                        '${item.quantity} × ${controller.currencyController.text} ${item.unitPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.bodySmall,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${controller.currencyController.text} ${item.totalPrice.toStringAsFixed(2)}',
                            style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.mustardYellow),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close,
                                size: 18, color: AppColors.disabled),
                            onPressed: () =>
                                controller.removeLineItem(e.key),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.heading3),
                      Obx(() => Text(
                            '${controller.currencyController.text} ${controller.total.toStringAsFixed(2)}',
                            style: AppTextStyles.heading3.copyWith(
                                color: AppColors.mustardYellow),
                          )),
                    ],
                  ),
                ],
              );
            }),
            Obx(() {
              final err = controller.error.value;
              if (err == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(err,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.redNCS)),
              );
            }),
            const SizedBox(height: 24),
            if (!isView) ...[
              Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.save(
                            status: InvoiceStatus.issued),
                    child: const Text('Issue Invoice'),
                  )),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () =>
                    controller.save(status: InvoiceStatus.draft),
                child: const Text('Save as Draft'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showAddLineItemDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '1');
    final priceCtrl = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Line Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Item Name')),
            const SizedBox(height: 10),
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Unit Price'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final qty = int.tryParse(qtyCtrl.text) ?? 1;
              final price = double.tryParse(priceCtrl.text) ?? 0.0;
              controller.addLineItem(InvoiceLineItem()
                ..itemId = ''
                ..sku = ''
                ..name = nameCtrl.text.trim()
                ..quantity = qty
                ..unitPrice = price
                ..totalPrice = qty * price);
              nameCtrl.dispose();
              qtyCtrl.dispose();
              priceCtrl.dispose();
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
