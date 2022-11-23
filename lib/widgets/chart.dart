import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);


      return {'day': DateFormat.E().format(weekDay).substring(0,1), 'amount': totalSum};
    }).reversed.toList();
  }

  double calculatePercent(double amt){
    double allSum = 0;
    for(var i=0;i<recentTransactions.length;i++){
      allSum+=recentTransactions[i].amount;
    }
    if(allSum==0){
      return 0;
    }
    double ans = (amt/allSum);
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          ...(groupedTransactionValues.map((data) {
            return Flexible(
              // flex: 2,
              fit: FlexFit.tight,
              child: ChartBar(
              data['day'].toString(), data['amount'],
              calculatePercent(data['amount'])
              ));
          }).toList())
        ])));
  }
}
