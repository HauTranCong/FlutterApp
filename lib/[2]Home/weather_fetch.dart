import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:viis_pyriot/%5B2%5DHome/weather_model.dart';

const endPointUrl = 'https://api.openweathermap.org/data/2.5';
const apiKey = '9da3764b5c09ec37a6bf2fc23f775386';
const lat = 10.75;
const lon = 106.6667;

Future<WeatherModel> fetchWeather() async {
  const requestUrl =
      '$endPointUrl/weather?lat=$lat&lon=$lon&lang=vi&appid=$apiKey&units=metric';
  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return WeatherModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
