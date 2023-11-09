import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/components/weather_result.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  TextEditingController cityCtrl = TextEditingController();
  Map<String, dynamic>? weatherResult;
  double temp = 0;
  String errorMsg = '';
  bool isApiCalling = true;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cityCtrl,
              decoration:
                  const InputDecoration(labelText: "Enter a city name..."),
            ),
          ),
          ElevatedButton(
            child: const Text("Get Weather"),
            onPressed: () async {
              String url =
                  'http://api.openweathermap.org/data/2.5/weather?q=${cityCtrl.text}&appid=32ad84d2a41f15df8af1a765bb38c530&units=metric';

              var response = await http.get(Uri.parse(url));
              print(response.statusCode);
              if (response.statusCode == 200) {
                isError = false;
                weatherResult = jsonDecode(response.body);
                temp = weatherResult!['main']['temp'];
              } else {
                isError = true;
                errorMsg = jsonDecode(response.body)['message'];
                print(errorMsg);
              }
              isApiCalling = false;
              setState(() {});
            },
          ),
          Expanded(
            child: Center(
              child: isApiCalling
                  ? const Text("")
                  : isError
                      ? Text(errorMsg.toUpperCase())
                      : WeatherCard(temp: temp),
            ),
          )
        ],
      ),
    );
  }
}
