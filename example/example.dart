// example/example.dart

import 'package:flutter/material.dart';
import 'package:network_internet_checker/network_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConnectivityWidget(
        textButton: Text('Retry'),
        noInternetText: Text('No Internet Connection. Please try again.'),
        addIcon: true,
        icon: Icon(Icons.signal_wifi_off),
        onButtonPressed: () {
          // Your onButtonPressed logic here
        },
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Checker Example'),
      ),
      body: Center(
        child: Text('You are connected to the internet!'),
      ),
    );
  }
}
