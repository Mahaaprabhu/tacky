import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './../models/entry.dart';

class EntryWidget extends StatelessWidget {
  final Entry entry;
  final int id;
  final TextEditingController deleteController = TextEditingController();
  final Function deleteEntryCallBack;

  EntryWidget({@required this.id, @required this.entry, @required this.deleteEntryCallBack});

  void _removeEntry() {
    if(
      this.deleteController.value.text.isEmpty 
      || int.parse(deleteController.value.text) != 1
    ) return;
    this.deleteEntryCallBack(this.id, this);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          /////////// S. No
          Container(
              child: Text(
            (this.id+1).toString(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
          /////////// Date
          Container(
              child: Text(entry.date, style: TextStyle(color: Colors.purple))),
          /////////// Food Done?
          Container(
              child: Icon(
            Icons.local_dining,
            size: 25,
            color:
                this.entry.foodDone == 1 ? Colors.purple : Colors.purple[100],
          )),
          /////////// Walk Done?
          Container(
              child: Icon(
            Icons.directions_run,
            size: 25,
            color:
                this.entry.walkDone == 1 ? Colors.purple : Colors.purple[100],
          )),
          Container(
            child: Row(
              children: <Widget>[
                /////////// Delete Secret
                Container(
                    width: 10,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: this.deleteController,
                      autofocus: false,
                    )),
                /////////// Delete
                Container(
                  child: IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () => this._removeEntry(),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
