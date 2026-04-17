import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:wms_pro/features/invoices/domain/invoice.dart';

abstract class InvoicePdfService {
  static Future<pw.Document> build(Invoice invoice) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _header(invoice),
            pw.SizedBox(height: 24),
            _customerBlock(invoice),
            pw.SizedBox(height: 24),
            _lineItemsTable(invoice),
            pw.SizedBox(height: 16),
            _totalRow(invoice),
          ],
        ),
      ),
    );

    return doc;
  }

  static pw.Widget _header(Invoice invoice) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'WMS Pro',
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                invoice.invoiceNumber,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                _formatDate(invoice.issuedAt),
                style: const pw.TextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
      );

  static pw.Widget _customerBlock(Invoice invoice) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Bill To',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 11)),
          pw.SizedBox(height: 4),
          pw.Text(invoice.customerName),
          if (invoice.customerAddress.isNotEmpty)
            pw.Text(invoice.customerAddress),
        ],
      );

  static pw.Widget _lineItemsTable(Invoice invoice) {
    final headerStyle =
        pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
    final cellStyle = pw.TextStyle(fontSize: 10);

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FixedColumnWidth(50),
        2: const pw.FixedColumnWidth(70),
        3: const pw.FixedColumnWidth(80),
      },
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('Item', style: headerStyle)),
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('Qty', style: headerStyle)),
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('Unit Price', style: headerStyle)),
            pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text('Total', style: headerStyle)),
          ],
        ),
        ...invoice.lineItems.map(
          (item) => pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(item.name, style: cellStyle)),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('${item.quantity}', style: cellStyle)),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(
                      '${invoice.currency} ${item.unitPrice.toStringAsFixed(2)}',
                      style: cellStyle)),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(
                      '${invoice.currency} ${item.totalPrice.toStringAsFixed(2)}',
                      style: cellStyle)),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _totalRow(Invoice invoice) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text(
            'Total: ${invoice.currency} ${invoice.totalAmount.toStringAsFixed(2)}',
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, fontSize: 13),
          ),
        ],
      );

  static String _formatDate(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
}
