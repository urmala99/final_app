import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  String description;

  Weather({this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    return Weather(description: description);
  }
}

class Forecast {
  final double temperature;

  Forecast({this.temperature});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return Forecast(temperature: temperature);
  }
}

class WeatherResponse {
  String city;
  Forecast forecast;
  Weather weather;

  WeatherResponse({this.city, this.forecast, this.weather});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final city = json['city'];

    final forecastJson = json['main'];
    final forecast = Forecast.fromJson(forecastJson);

    final weatherJson = json['weather'][0];
    final weather = Weather.fromJson(weatherJson);

    return WeatherResponse(city: city, forecast: forecast, weather: weather);
  }
}

class WeatherService {
  Future<WeatherResponse> getWeather(String city) async {
    final parameters = {
      'q': city,
      'appid': '60cbc4469343fb76ce585a181f845404',
      'units': 'metric'
    };

    final uri =
        Uri.https('api.openweathermap.org', '/data/2.5/weather', parameters);

    final res = await http.get(uri);

    print(res.body);
    final json = jsonDecode(res.body);
    return WeatherResponse.fromJson(json);
  }
}
