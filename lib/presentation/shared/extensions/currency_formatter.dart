import 'package:intl/intl.dart';

extension CurrencyFormatter on double {
  String toCurrencyString() {
    // TODO: allow other formats
    final formatCurrency = NumberFormat.currency(locale: "de_DE", symbol: "€");
    return formatCurrency.format(this);
  }
}
