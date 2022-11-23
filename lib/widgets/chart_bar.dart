import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label = "";
  double spendingAmount = 0;
  double spendingPercent = 0;
  // VoidCallback calculatePercent;

  ChartBar(this.label, this.spendingAmount, this.spendingPercent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('₹${spendingAmount.toStringAsFixed(0)}')
            ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius:BorderRadius.circular(10),

                  ),
                  
            ),

            FractionallySizedBox(
              heightFactor: spendingPercent,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  color: Color.fromARGB(255, 66, 208, 47),
                  borderRadius:BorderRadius.circular(10),
                ),
              )
            )

          ]),
        ),
        SizedBox(
          height: 4,
        ),
        Text('${label}'),
      ],
    );
  }
}
