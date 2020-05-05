import 'package:flutter/foundation.dart';

class Transacrion {
  final String id;
  final String title;
  final double amount;
  final String type;
  final DateTime date;

  Transacrion(
      {@required this.id,
      @required this.title,
      @required this.amount,
      this.type = 'general-expense',
      @required this.date});
}
