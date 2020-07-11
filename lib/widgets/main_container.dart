import 'package:flutter/material.dart';
import 'package:tacky/models/entry.dart';
import 'package:tacky/widgets/entry_widget.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'add_entry.dart';
import 'entries_view.dart';
import 'stats_view.dart';

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  List<Widget> widgetEntries = [];
  List<Entry> dbEntries = [];
  int totalAmount = 0;
  Future<Database> database;

  _MainContainerState() {
    this._connectToDb()
    .whenComplete(() => this._startDataLoad());
  }

  void _startDataLoad() {
    setState(() {
      this._getDbEntries()
        .then((entries) => {this.dbEntries = entries})
        .whenComplete(() => this._loadWiggetState());
      
    });
  }

  void _loadWiggetState() {
    setState(() {
      this.widgetEntries = _generateWidgetsFromEntries(dbEntries);
      this._calculateTotalAmount();
    });
  }

  Future<void> _connectToDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    this.database = openDatabase(
      join(await getDatabasesPath(), 'tacky_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tacky(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, date TEXT, foodDone INTEGER, walkDone INTEGER, amount INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> _insertDbEntry(Entry entry) async {
    final Database db = await database;
    await db.insert(
      'tacky',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Entry>> _getDbEntries() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tacky');

    // Convert the List<Map<String, dynamic> into a List<Entry>.
    return List.generate(maps.length, (i) {
      return Entry(
        id: maps[i]['id'],
        date: maps[i]['date'],
        foodDone: maps[i]['foodDone'],
        walkDone: maps[i]['walkDone'],
        amount: maps[i]['amount'],
      );
    });
  }

  Future<void> _deleteDbEntry(int id) async {
    final db = await database;

    await db.delete(
      'tacky',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  void _calculateTotalAmount() {
    int total = 0;
    for (Entry entry in this.dbEntries) {
      total += entry.amount;
    }
    this.totalAmount = total;
  }

  List<Widget> _generateWidgetsFromEntries(List<Entry> entries) {
    List<Widget> generatedWidgets = [];
    for (int i = 0; i < entries.length; i++) {
      generatedWidgets.add(EntryWidget(
        entry: entries[i],
        id: i,
        deleteEntryCallBack: this._removeEntry,
      ));
    }
    return generatedWidgets;
  }

  void _addEntry(Entry entry) {
    this._insertDbEntry(entry).whenComplete(() => this._startDataLoad());
    /*setState(() {
      this.widgetEntries.add(EntryWidget(
            entry: entry,
            id: this.widgetEntries.length,
            deleteEntryCallBack: this._removeEntry,
          ));
      this.dbEntries.add(
            Entry(
              date: entry.date,
              foodDone: entry.foodDone,
              walkDone: entry.walkDone,
              amount: entry.amount,
            ),
          );
      this._calculateTotalAmount();
    });*/
  }

  void _removeEntry(int entryId, Widget widgetReference) {
    this.widgetEntries = [];
    final Entry entryToBeRemoved = this.dbEntries[entryId];
    this._deleteDbEntry(entryToBeRemoved.id);
    this.dbEntries.removeAt(entryId);
    setState(() {
      this.widgetEntries.addAll(_generateWidgetsFromEntries(dbEntries));
      this._calculateTotalAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          StatsView(this.totalAmount),
          AddEntry(
            addEntryCallBack: this._addEntry,
          ),
          EntriesView(
            widgetEntries: this.widgetEntries,
          )
        ],
      ),
    );
  }
}
