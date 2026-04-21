// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'WMS Pro';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String hello(String name) {
    return 'Hello, $name';
  }

  @override
  String get signInSubtitle => 'Sign in to your account';

  @override
  String get login => 'Log In';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Log In';

  @override
  String get loginError => 'Invalid email or password';

  @override
  String get logoutButton => 'Log Out';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get inventory => 'Inventory';

  @override
  String get scanner => 'Scanner';

  @override
  String get invoices => 'Invoices';

  @override
  String get settings => 'Settings';

  @override
  String get addItem => 'Add Item';

  @override
  String get editItem => 'Edit Item';

  @override
  String get deleteItem => 'Delete Item';

  @override
  String get sku => 'SKU';

  @override
  String get itemName => 'Item Name';

  @override
  String get description => 'Description';

  @override
  String get quantity => 'Quantity';

  @override
  String get unit => 'Unit';

  @override
  String get location => 'Location';

  @override
  String get barcode => 'Barcode';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get loading => 'Loading…';

  @override
  String get noItems => 'No items yet';

  @override
  String get noInvoices => 'No invoices yet';

  @override
  String get createInvoice => 'Create Invoice';

  @override
  String get newInvoice => 'New Invoice';

  @override
  String get issueInvoice => 'Issue Invoice';

  @override
  String get saveAsDraft => 'Save as Draft';

  @override
  String get lineItems => 'Line Items';

  @override
  String get noLineItems => 'No line items';

  @override
  String get total => 'Total';

  @override
  String get addLineItem => 'Add Line Item';

  @override
  String get invoiceNumber => 'Invoice #';

  @override
  String get customerName => 'Customer Name';

  @override
  String get customerAddress => 'Customer Address';

  @override
  String get currency => 'Currency';

  @override
  String get totalAmount => 'Total';

  @override
  String get shareInvoice => 'Share PDF';

  @override
  String get previewInvoice => 'Preview PDF';

  @override
  String get unitPrice => 'Unit Price';

  @override
  String get itemDetails => 'Item Details';

  @override
  String get billingDetails => 'Billing Details';

  @override
  String get scanBarcode => 'Scan Barcode';

  @override
  String get scanningInstruction => 'Point the camera at a barcode or QR code';

  @override
  String get cameraPermissionDenied =>
      'Camera access required. Enable it in Settings.';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get dutch => 'Dutch';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleVendor => 'Vendor';

  @override
  String totalItems(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString items',
      one: '$countString item',
    );
    return '$_temp0';
  }

  @override
  String get errorOccurred => 'Something went wrong';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get totalValue => 'Total Value';

  @override
  String get lowStockAlert => 'Low Stock';

  @override
  String get scanResult => 'Scan Result';

  @override
  String get itemNotFound => 'No item matched this barcode';

  @override
  String get invoiceStatus => 'Status';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusIssued => 'Issued';

  @override
  String get defaultAdminNote =>
      'Default admin credentials: admin@wms.pro / Admin@123 — change after first login';
}
