import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/pages/city.dart';
import 'package:weather/pages/location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cityCtrl = TextEditingController();
  Map<String, dynamic>? weatherResult;
  double temp = 0;
  String errorMsg = '';
  bool isApiCalling = true;
  bool isError = false;
  bool isCity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isCity = !isCity;
                });
              },
              icon: const Icon(Icons.location_on_outlined))
        ],
      ),
      body: isCity ? const CityPage() : const LocationPage(),
    );
  }
}
