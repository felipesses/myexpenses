import 'package:intl/intl.dart';

String formatNumber(num number) {
  final numberFormatter = NumberFormat('#,##0.00', 'pt_br');

  return 'R\$ ${numberFormatter.format(number)}';
}
