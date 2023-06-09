import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Models/weather_model.dart';
import '../Models/weather_model_controller.dart';

class WeatherRepository {
  static Future<int> getForecastData({required String city}) async {
    try {
      var headers = {
        'X-RapidAPI-Key': ' 4ba134b8e1msh225dac5b0fc4db6p1de760jsn5e94b47909ad',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      };
      var request = http.MultipartRequest(
          'GET',
          Uri.parse(
              'https://weatherapi-com.p.rapidapi.com/forecast.json?q=$city&days=10'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        WeatherModeController.weatherModel = WeatherModel.fromJson(
            jsonDecode(await response.stream.bytesToString()));
      } else {}
      return response.statusCode;
    } on SocketException {
      return 501;
    } on Exception {
      return 0;
    }
  }
}
