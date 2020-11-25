import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bus_android/painter/bus_raod_painter.dart';
import 'package:bus_android/server/busInformation.dart';
import 'package:bus_android/ui/bus_road_ui.dart';
import 'package:bus_android/ui/information_ui.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

Axis axis;
Axis axis2;
Size size;
final formkey = GlobalKey<FormState>();
String busNumber = '버스번호';
DateTime dateTime = DateTime.now();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print('Home Page init');

    super.initState();

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        test += 10;
        dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: getInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            String prevStationName = data['prevStationName'];
            String nowStationName = data['nowStationName'];
            String nextStationName = data['nextStationName'];
            int nowPassenger = data['nowPassenger'];
            int nextPassenger = data['nextPassenger'];

            return OrientationBuilder(
              builder: (context, orientation) {
                Axis getDirection1 = orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal;
                Axis getDirection2 = orientation != Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal;

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.grey.withOpacity(0.2), BlendMode.dstATop),
                        image: AssetImage('images/background.jpg'),
                        fit: BoxFit.fill),
                  ),
                  child: Flex(
                    direction: getDirection1,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(1),
                                      offset: Offset(10, 10),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  DateFormat('HH:mm').format(dateTime),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              BusRoadUI(prevStationName, nowStationName),
                              Positioned(
                                right: 0,
                                child: Text(
                                  '버스 번호 - 101',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue[100], Colors.blue[900]]),
                          ),
                          child: Flex(
                            direction: getDirection2,
                            children: [
                              Expanded(
                                child: Container(
                                  child: InformationUI(
                                    busStopName: nowStationName,
                                    peopleCount: nowPassenger,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: InformationUI(
                                    busStopName: nextStationName,
                                    peopleCount: nextPassenger,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                );
              },
            );
          } else
            return Container();
        },
      ),
    );
  }

  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   // Calling the same function "after layout" to resolve the issue.
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: WillPopScope(
  //           onWillPop: () {
  //             return Future(() => false);
  //           },
  //           child: Container(
  //             padding: EdgeInsets.only(
  //                 bottom: MediaQuery.of(context).viewInsets.bottom),
  //             child: Container(
  //               margin: EdgeInsets.all(20),
  //               child: Form(
  //                 key: formkey,
  //                 child: Column(
  //                   children: [
  //                     Text('버스 번호를 입력해주세요'),
  //                     TextFormField(
  //                       validator: (value) {
  //                         if (value.isEmpty) {
  //                           return '버스 번호를 입력해주세요';
  //                         } else {
  //                           return null;
  //                         }
  //                       },
  //                       onSaved: (newValue) => busNumber = newValue,
  //                     ),
  //                     RaisedButton(
  //                       onPressed: () {
  //                         if (formkey.currentState.validate()) {
  //                           formkey.currentState.save();

  //                           Navigator.pop(context);
  //                         }
  //                       },
  //                       child: Text(
  //                         '완료',
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(30),
  //                       ),
  //                       color: Colors.blue[200],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget setDivider() {
    Widget divider;

    if (axis2 == Axis.horizontal) {
      divider = VerticalDivider(
        thickness: 5,
      );
    } else {
      divider = Divider(
        thickness: 5,
      );
    }

    return divider;
  }

  BorderRadius getBorderRadius() {
    BorderRadius borderRadius;

    if (axis2 == Axis.vertical) {
      borderRadius = BorderRadius.only(
          topLeft: Radius.circular(30), bottomLeft: Radius.circular(30));
    } else {
      borderRadius = BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30));
    }

    return borderRadius;
  }
}
