import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/invoices/domain/invoice.dart';
import 'invoice_controller.dart';

class InvoiceListPage extends GetView<InvoiceController> {
  const InvoiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoices')),
      body: Obx(() {
        if (controller.isLoading.value && controller.invoices.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.value != null && controller.invoices.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.error.value!, style: AppTextStyles.bodyMedium),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: controller.loadInvoices,
                    child: const Text('Try Again')),
              ],
            ),
          );
        }
        if (controller.invoices.isEmpty) {
          return Center(
            child: Text('No invoices yet', style: AppTextStyles.bodyMedium),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadInvoices,
          color: AppColors.redNCS,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: controller.invoices.length,
            itemBuilder: (_, i) {
              final inv = controller.invoices[i];
              return Card(
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(inv.invoiceNumber,
                      style: AppTextStyles.bodyLarge),
                  subtitle: Text(
                    inv.customerName,
                    style: AppTextStyles.bodySmall,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${inv.currency} ${inv.totalAmount.toStringAsFixed(2)}',
                        style: AppTextStyles.bodyLarge
                            .copyWith(color: AppColors.mustardYellow),
                      ),
                      const SizedBox(height: 4),
                      _StatusChip(inv.status),
                    ],
                  ),
                  onTap: () => controller.openView(inv),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.openCreate,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final InvoiceStatus status;
  const _StatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    final isDraft = status == InvoiceStatus.draft;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isDraft ? AppColors.surfaceVariant : AppColors.mustardYellow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isDraft ? 'Draft' : 'Issued',
        style: AppTextStyles.label.copyWith(
          color: isDraft ? AppColors.onSurfaceVariant : AppColors.black,
        ),
      ),
    );
  }
}
