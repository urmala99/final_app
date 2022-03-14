import 'package:flutter/material.dart';
import 'weather.dart';
import 'package:final_app/first_screen.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _TextController = TextEditingController();
  final _weatherService = WeatherService();

  WeatherResponse _res;

  void _search() async {
    final response = await _weatherService.getWeather(_TextController.text);
    setState(() => _res = response);
    _TextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text('Second screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_res != null)
              Column(
                children: [
                  Text(
                    '${_res.forecast.temperature}°',
                    style: TextStyle(fontSize: 80),
                  ),
                  Text(_res.weather.description)
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 300,
                child: TextField(
                    controller: _TextController,
                    decoration: InputDecoration(labelText: 'Search for city'),
                    textAlign: TextAlign.center),
              ),
            ),
            ElevatedButton(onPressed: _search, child: Text('Search')),
            ElevatedButton(
              child: Text('Return to Home'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstScreen()),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
