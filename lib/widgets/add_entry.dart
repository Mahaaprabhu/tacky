import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './../models/entry.dart';

class AddEntry extends StatefulWidget {

  final Function addEntryCallBack;

  AddEntry({this.addEntryCallBack});

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  bool foodDone = false;
  bool walkDone = false;
  int amount = 0;

  void _setAmount() {
    this.setState(() {
      if (foodDone && walkDone)
        this.amount = 100;
      else if (foodDone || walkDone)
        this.amount = 50;
      else
        this.amount = 0;
    });
  }

  void _addEntry() {
    if(this.amount <= 0) return;
    widget.addEntryCallBack(
      Entry(
          date: DateFormat('dd/MM/yyyy').format(DateTime.now().toLocal()).toString(), 
          foodDone: this.foodDone ? 1 : 0, 
          walkDone: this.walkDone ? 1 : 0, 
          amount: this.amount
      ),
    );
    setState(() {
      this.amount = 0;
      this.foodDone = false;
      this.walkDone = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.local_dining,
                color: this.foodDone
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorLight,
                size: 40,
              ),
              onPressed: () => {
                this.setState(() {
                  this.foodDone = !this.foodDone;
                  this._setAmount();
                })
              },
            ),
            IconButton(
              icon: Icon(
                Icons.directions_run,
                color: this.walkDone
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorLight,
                size: 40,
              ),
              onPressed: () => {
                this.setState(() {
                  this.walkDone = !this.walkDone;
                  this._setAmount();
                })
              },
            ),
            SizedBox(),
            SizedBox(),
            SizedBox(),
            IconButton(
              icon: Icon(
                Icons.done_all,
                color: this.foodDone || this.walkDone
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColorLight,
                size: 40,
              ),
              onPressed: () => _addEntry(),
            ),
            Container(
              width: 100,
              color: this.foodDone || this.walkDone
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColorLight,
              child: Text(
                " ₹${this.amount.toString().padRight(3)}",
                style: TextStyle(
                    color: this.foodDone || this.walkDone
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontSize: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
