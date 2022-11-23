import 'package:flutter/material.dart';

class Transaction {
  // const MyWidget({super.key});
  DateTime id = DateTime.now();
  String title = "";
  double amount = 0;
  DateTime date;

  Transaction({required this.id,
      required this.title,
      required this.amount,
      required this.date
      });
}
