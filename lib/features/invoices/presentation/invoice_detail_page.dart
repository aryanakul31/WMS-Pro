import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/invoices/domain/invoice.dart';
import 'package:wms_pro/features/invoices/domain/invoice_line_item.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'invoice_controller.dart';

class InvoiceDetailPage extends GetView<InvoiceController> {
  const InvoiceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isView = controller.selectedInvoice.value != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isView
            ? controller.selectedInvoice.value!.invoiceNumber
            : l10n.newInvoice),
        actions: [
          if (isView) ...[
            IconButton(
              tooltip: l10n.previewInvoice,
              icon: const Icon(Icons.picture_as_pdf_outlined),
              onPressed: () =>
                  controller.previewPdf(controller.selectedInvoice.value!),
            ),
            IconButton(
              tooltip: l10n.shareInvoice,
              icon: const Icon(Icons.share_outlined),
              onPressed: () =>
                  controller.shareAsPdf(controller.selectedInvoice.value!),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.billingDetails, style: AppTextStyles.heading3),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller.customerNameController,
                    enabled: !isView,
                    style: AppTextStyles.bodyLarge,
                    decoration: InputDecoration(labelText: l10n.customerName),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller.customerAddressController,
                    enabled: !isView,
                    style: AppTextStyles.bodyLarge,
                    maxLines: 2,
                    decoration: InputDecoration(labelText: l10n.customerAddress),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller.currencyController,
                    enabled: !isView,
                    style: AppTextStyles.bodyLarge,
                    decoration: InputDecoration(labelText: l10n.currency),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.lineItems, style: AppTextStyles.heading3),
                      if (!isView)
                        TextButton.icon(
                          onPressed: () => _showAddLineItemDialog(context),
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(l10n.addLineItem),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.lineItems.isEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Center(
                    child: Text(
                      l10n.noLineItems,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.text03),
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  ...controller.lineItems.asMap().entries.map((e) {
                    final item = e.value;
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.borderSubtle),
                        ),
                      ),
                      child: Material(
                        color: AppColors.background,
                        child: InkWell(
                          onTap: isView ? null : () {}, // Could allow edit
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.name,
                                          style: AppTextStyles.bodyMedium),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${item.quantity} × ${controller.currencyController.text} ${item.unitPrice.toStringAsFixed(2)}',
                                        style: AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.text02),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${controller.currencyController.text} ${item.totalPrice.toStringAsFixed(2)}',
                                      style: AppTextStyles.bodyLarge.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                if (!isView) ...[
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 18, color: AppColors.text03),
                                    onPressed: () =>
                                        controller.removeLineItem(e.key),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.total, style: AppTextStyles.heading3),
                        Obx(() => Text(
                              '${controller.currencyController.text} ${controller.total.toStringAsFixed(2)}',
                              style: AppTextStyles.heading2.copyWith(
                                color: AppColors.blue60,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            }),
            Obx(() {
              final err = controller.error.value;
              if (err == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Text(
                  err,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.danger),
                ),
              );
            }),
            const SizedBox(height: 48),
            if (!isView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.save(
                                  status: InvoiceStatus.issued),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(l10n.issueInvoice),
                        )),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.save(status: InvoiceStatus.draft),
                      child: Text(l10n.saveAsDraft),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddLineItemDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '1');
    final priceCtrl = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.addLineItem),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: l10n.itemName),
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: qtyCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l10n.quantity),
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: l10n.unitPrice),
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(l10n.cancel),
          ),
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
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 48),
            ),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
