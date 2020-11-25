import 'package:flutter/material.dart';

class InformationUI extends StatefulWidget {
  final busStopName;
  final peopleCount;

  InformationUI({this.busStopName, this.peopleCount});

  @override
  _InformationUIState createState() => _InformationUIState();
}

class _InformationUIState extends State<InformationUI> {
  String busStopName;
  int peopleCount;

  @override
  void initState() {
    super.initState();

    busStopName = widget.busStopName;
    peopleCount = widget.peopleCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            busStopName,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '$peopleCount',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
