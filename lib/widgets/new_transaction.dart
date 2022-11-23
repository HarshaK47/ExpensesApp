import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  
  Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController=TextEditingController();

  final amountController=TextEditingController();
  DateTime dateController = DateTime(2001);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final enteredDate = dateController;

    if(enteredTitle.isEmpty || enteredAmount<=0 || enteredDate == DateTime(2001)){
      return ;
    }

    widget.addNewTransaction(enteredTitle,enteredAmount,enteredDate);

    Navigator.of(context).pop();
  }


  void presentDatePicker(){
    showDatePicker(
      context: context,
     initialDate: DateTime.now(), 
     firstDate: DateTime(2010), 
     lastDate: DateTime.now(),
     ).then((pickedDate){
      if(pickedDate == null){
        return ;
      }
      setState(() {
        dateController = pickedDate;
      });
      

     });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                 
                ),

                TextField(
                  
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                  
                ),

                Container(
                  height: 70,
                  child: Row(children: <Widget>[
                    (dateController==DateTime(2001))?Expanded(child: Text("No date chosen")):Expanded(child: Text(DateFormat.yMd().format(dateController).toString())),
                    
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: TextStyle(fontWeight: FontWeight.bold), 
                      ),
                      child: Text('Choose Date'),
                    onPressed: (){presentDatePicker();}, 
                    ),

                  ],),
                ),

                ElevatedButton(
                  child: Text("Add Transaction"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: submitData,
                ),
              ],)
            )
          );
  }
}