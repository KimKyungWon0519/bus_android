import 'package:bus_android/painter/bus_raod_painter.dart';
import 'package:flutter/material.dart';

class BusRoadUI extends StatefulWidget {
  final prevStationName;
  final nowStationName;

  BusRoadUI(
    this.prevStationName,
    this.nowStationName,
  );

  @override
  _BusRoadUIState createState() => _BusRoadUIState();
}

class _BusRoadUIState extends State<BusRoadUI> {
  String prevStationName;
  String nowStationName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prevStationName = widget.prevStationName;
    nowStationName = widget.nowStationName;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: CustomPaint(
        size: Size(size.width, size.height),
        painter: BusRoad(
            nowStationName: nowStationName, prevStationName: prevStationName),
      ),
    );
  }
}
