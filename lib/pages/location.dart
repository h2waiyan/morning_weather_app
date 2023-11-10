import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/components/weather_result.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Map<String, dynamic>? weatherResult;
  double temp = 0;
  String errorMsg = '';
  bool isApiCalling = true;
  bool isError = false;
  Position? mylocation;

  getWeather() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${mylocation!.latitude}&lon=${mylocation!.longitude}&appid=a282b757c13c4bae4b14df933c62959c&units=metric';

    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      weatherResult = jsonDecode(response.body);
      temp = weatherResult!['main']['temp'];
    } else {
      isError = true;
      errorMsg = jsonDecode(response.body)['message'];
      print(errorMsg);
    }
    isApiCalling = false;
    setState(() {});
  }

  getLocation() async {
    var permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    setState(() {
      mylocation = location;
    });
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isApiCalling
          ? const Text("")
          : isError
              ? Text(errorMsg.toUpperCase())
              : WeatherCard(temp: temp),
    );
  }
}
