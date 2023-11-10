import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';

Future<WeatherResult> getWeather(city) async {
  // String locationUrl =
  // 'https://api.openweathermap.org/data/2.5/weather?lat=${mylocation!.latitude}&lon=${mylocation!.longitude}&appid=a282b757c13c4bae4b14df933c62959c&units=metric';

  String url =
      'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=32ad84d2a41f15df8af1a765bb38c530&units=metric';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    WeatherResult weatherResult = weatherResultFromJson(response.body);

    return weatherResult; // 31.23
  } else {
    throw Exception("City Not Found");
  }
}
