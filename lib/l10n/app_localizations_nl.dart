// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'WMS Pro';

  @override
  String get login => 'Inloggen';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Wachtwoord';

  @override
  String get loginButton => 'Inloggen';

  @override
  String get loginError => 'Ongeldig e-mailadres of wachtwoord';

  @override
  String get logoutButton => 'Uitloggen';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get inventory => 'Voorraad';

  @override
  String get scanner => 'Scanner';

  @override
  String get invoices => 'Facturen';

  @override
  String get settings => 'Instellingen';

  @override
  String get addItem => 'Artikel toevoegen';

  @override
  String get editItem => 'Artikel bewerken';

  @override
  String get deleteItem => 'Artikel verwijderen';

  @override
  String get sku => 'SKU';

  @override
  String get itemName => 'Artikelnaam';

  @override
  String get description => 'Omschrijving';

  @override
  String get quantity => 'Hoeveelheid';

  @override
  String get unit => 'Eenheid';

  @override
  String get location => 'Locatie';

  @override
  String get barcode => 'Barcode';

  @override
  String get save => 'Opslaan';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get confirm => 'Bevestigen';

  @override
  String get loading => 'Laden…';

  @override
  String get noItems => 'Nog geen artikelen';

  @override
  String get noInvoices => 'Nog geen facturen';

  @override
  String get createInvoice => 'Factuur aanmaken';

  @override
  String get invoiceNumber => 'Factuur #';

  @override
  String get customerName => 'Klantnaam';

  @override
  String get customerAddress => 'Klantadres';

  @override
  String get currency => 'Valuta';

  @override
  String get totalAmount => 'Totaal';

  @override
  String get shareInvoice => 'PDF delen';

  @override
  String get addLineItem => 'Regel toevoegen';

  @override
  String get unitPrice => 'Eenheidsprijs';

  @override
  String get scanBarcode => 'Barcode scannen';

  @override
  String get scanningInstruction => 'Richt de camera op een barcode of QR-code';

  @override
  String get cameraPermissionDenied =>
      'Cameratoegang vereist. Schakel het in via Instellingen.';

  @override
  String get language => 'Taal';

  @override
  String get english => 'Engels';

  @override
  String get dutch => 'Nederlands';

  @override
  String get roleAdmin => 'Beheerder';

  @override
  String get roleVendor => 'Leverancier';

  @override
  String totalItems(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString artikelen',
      one: '$countString artikel',
    );
    return '$_temp0';
  }

  @override
  String get errorOccurred => 'Er is iets misgegaan';

  @override
  String get tryAgain => 'Probeer opnieuw';

  @override
  String get totalValue => 'Totale waarde';

  @override
  String get lowStockAlert => 'Lage voorraad';

  @override
  String get scanResult => 'Scanresultaat';

  @override
  String get itemNotFound => 'Geen artikel gevonden voor deze barcode';

  @override
  String get invoiceStatus => 'Status';

  @override
  String get statusDraft => 'Concept';

  @override
  String get statusIssued => 'Verstuurd';

  @override
  String get defaultAdminNote =>
      'Standaard beheerder: admin@wms.pro / Admin@123 — wijzig na eerste login';
}
