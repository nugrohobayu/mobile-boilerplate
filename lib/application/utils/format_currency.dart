import 'dart:async';

import 'package:intl/intl.dart';

Future<String> formatCurrencyIdn(int amount) async {
  String formattedAmount = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(amount);
  if (formattedAmount != '0') {
    return formattedAmount;
  }
  return 'Rp 0';
}

String formatCurrency(int amount) {
  String formattedAmount = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(amount);
  if (formattedAmount != '0') {
    return formattedAmount;
  }
  return 'Rp 0';
}
