import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  DateTime formatToLocale = dateTime.toLocal();
  String timezone = formatToLocale.timeZoneName;
  String formattedDate = DateFormat("d MMMM yyyy HH:mm", "id_ID").format(formatToLocale);
  return '$formattedDate $timezone';
}
