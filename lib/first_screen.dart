import 'package:final_app/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_app/third_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter application / Miika Urmala')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to the application!', style: TextStyle(fontSize: 31)),
          ElevatedButton(
            child: Text('Check the weather in your city! (Openweathermap API)'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              );
            },
          ),
          ElevatedButton(
            child: Text('To-do list(Firebase backend)'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThirdScreen()),
              );
            },
          ),
        ],
      )),
    );
  }
}
