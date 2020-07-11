import 'package:flutter/material.dart';

class EntriesView extends StatelessWidget {
  final List<Widget> widgetEntries;

  EntriesView({this.widgetEntries});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 400,
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView.builder(
            reverse: true,
            itemCount: widgetEntries.length,
            itemBuilder: (bCtx, index) => this.widgetEntries[index],
        )
    );
  }
}
