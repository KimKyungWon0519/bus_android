import 'dart:convert';

import 'package:http/http.dart' as http;

class BusInforMation {
  BusInforMation();
}

getInformation() async {
  String url = mainUrl + '/bus-coord?lat=$lat&lon=$lon';
  http.Response response = await http
      .put(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, double>{
        'lat': lat,
        'lon': lon,
      },
    ),
  )
      .timeout(
    Duration(seconds: 3),
    onTimeout: () {
      return null;
    },
  );

  var json = jsonDecode(response.body);
  lat = json['lat'];
  lon = json['lon'];
  offsetX = json['percent'];
  print(lat);
  print(lon);
  print(offsetX);
  print(json);

  return json;
}

final mainUrl = 'http://192.168.0.8:3000';
double lat = 33.50627382069555;
double lon = 126.49293860087423;
int offsetX;
