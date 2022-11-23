
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Quicksand',
        
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> transactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 2000, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly Groceries',
    //     amount: 1250,
    //     date: DateTime.now()),
  ];

  List<Transaction> get recentTransactions {
    return transactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime txDay){
    final newTx = Transaction(id: DateTime.now(),title: txTitle, amount: txAmount, date: txDay);
    setState(() {
      transactions.insert(0,newTx);
    });
  }

  void deleteTransaction(DateTime id){
    var index = -1;
    for(var i=0;i<transactions.length;i++){
      if(transactions[i].id==id){
        index = i;
        break;
      }
    }

    if(index==-1){
      return ;
    }

    setState((){
      transactions.removeAt(index);
    });
  }

  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(addNewTransaction);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses App', style: TextStyle(fontFamily: 'Open Sans'),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              startAddNewTransaction(context);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Chart(recentTransactions),
            TransactionList(transactions,deleteTransaction),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
