import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wms_pro/core/theme/app_colors.dart';
import 'package:wms_pro/core/theme/app_text_styles.dart';
import 'package:wms_pro/features/invoices/domain/invoice.dart';
import 'package:wms_pro/l10n/app_localizations.dart';
import 'invoice_controller.dart';

class InvoiceListPage extends GetView<InvoiceController> {
  const InvoiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.invoices)),
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
                  child: Text(l10n.tryAgain),
                ),
              ],
            ),
          );
        }
        if (controller.invoices.isEmpty) {
          return Center(
            child: Text(l10n.noInvoices, style: AppTextStyles.bodyMedium),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadInvoices,
          color: AppColors.blue60,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: controller.invoices.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final inv = controller.invoices[i];
              return Material(
                color: AppColors.background,
                child: InkWell(
                  onTap: () => controller.openView(inv),
                  hoverColor: AppColors.layer01Hover,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(inv.invoiceNumber,
                                  style: AppTextStyles.bodyLarge),
                              const SizedBox(height: 4),
                              Text(
                                inv.customerName,
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${inv.currency} ${inv.totalAmount.toStringAsFixed(2)}',
                              style: AppTextStyles.heading3,
                            ),
                            const SizedBox(height: 4),
                            _StatusChip(inv.status),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.text03,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_invoices',
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
    final l10n = AppLocalizations.of(context)!;
    final isDraft = status == InvoiceStatus.draft;

    // IBM Carbon Tag: 10% opacity blue bg, blue 60 text, 24px radius
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isDraft ? AppColors.layer01 : AppColors.blue60.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        isDraft ? l10n.statusDraft : l10n.statusIssued,
        style: AppTextStyles.label.copyWith(
          fontSize: 10,
          color: isDraft ? AppColors.text02 : AppColors.blue60,
        ),
      ),
    );
  }
}
