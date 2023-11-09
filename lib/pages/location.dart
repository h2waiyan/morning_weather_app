import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/components/weather_result.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Map<String, dynamic>? weatherResult;
  double temp = 0;
  String errorMsg = '';
  bool isApiCalling = true;
  bool isError = false;

  getWeather() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=22.92&lon=96.50&appid=a282b757c13c4bae4b14df933c62959c&units=metric';

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
