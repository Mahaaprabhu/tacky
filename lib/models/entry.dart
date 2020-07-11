import 'package:flutter/material.dart';

class Entry {
  final int id;
  final String date;
  final int foodDone;
  final int walkDone;
  final int amount;
  
  Entry({
    this.id, 
    @required this.date, 
    @required this.foodDone, 
    @required this.walkDone, 
    @required this.amount
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'date': date, 
      'foodDone': foodDone, 
      'walkDone': walkDone, 
      'amount': amount
    };
  }

}