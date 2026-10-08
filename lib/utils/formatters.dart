import 'package:intl/intl.dart';

String money(num value) => '${NumberFormat('#,##0.##').format(value)} EGP';
