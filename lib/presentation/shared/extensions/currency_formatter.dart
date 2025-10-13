import 'dart:ui' as ui;

import 'package:intl/intl.dart';

extension CurrencyFormatter on double {
  String toCurrencyString() {
    final locale = ui.PlatformDispatcher.instance.locale.toString();
    try {
      final formatCurrency = NumberFormat.simpleCurrency(locale: locale);
      return formatCurrency.format(this);
    } catch (e) {
      final formatCurrency =
          NumberFormat.currency(locale: "en_US", symbol: "\$");
      return formatCurrency.format(this);
    }
  }
}
