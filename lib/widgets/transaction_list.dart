import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions = [];
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);


  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      child: (transactions.length == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("No items to add"),
                  (Image.asset(
                    'assets/images/chair.jpg',
                    height: 125,
                    width: 125,
                  )),
                ],
              ),
            )
          : ListView(
              children: <Widget>[
                ...(transactions as List).map((tx) {
                  return (Card(
                      child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text('₹${tx.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),

                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(tx.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            Text(DateFormat.yMMMd().format(tx.date),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                          child: IconButton(icon: Icon(Icons.delete),
                          onPressed: (){
                            deleteTx(tx.id);
                          },
                          color: Colors.red,),
                        ),
                      ),
                    ],
                  )));
                }).toList(),
              ],
            ),
    );
  }
}
