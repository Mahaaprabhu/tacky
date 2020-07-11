import 'package:flutter/material.dart';

class StatsView extends StatefulWidget {

  final int totalAmount;

  StatsView(this.totalAmount);

  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {

  Color animeColor = Colors.white;
  Color animeColor1 = Colors.purple[50];
  Color animeColor2 = Colors.white;
  double fontSize = 20;
  double fontSize1 = 40;
  double fontSize2 = 20;
  bool state = true;

  _StatsViewState() {
    this._animateState();
  }

  _animateState() {
    Future.delayed(
      Duration(seconds: 1), 
      () => this._swapState()
    ).whenComplete(() => this._animateState());
  }

  _swapState() {
    this.setState(() {
      this.animeColor = state? animeColor1 : animeColor2;
      this.fontSize = state? fontSize1 : fontSize2;
      this.state = !state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedPhysicalModel(
              child: Container(
                padding: EdgeInsets.all(20),
                child:  Text(
                    '₹ ${widget.totalAmount}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark, 
                        fontSize: this.fontSize,
                        fontWeight: FontWeight.bold
                    ),
                ),
              ), 
              shape: BoxShape.circle, 
              elevation: 0, 
              color: this.animeColor, 
              shadowColor: Colors.black, 
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              animateColor: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
           
          ],
        ),
        elevation: 10,
      ),
    );
  }
}