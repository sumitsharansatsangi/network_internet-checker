import 'package:flutter/material.dart';

import 'NetworkWidget.dart';


void main() {
  runApp(const MyApp());
}

// Main app widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: Scaffold(
        body: ConnectivityWidget(
          noInternetText: const Text("Check your internet and try again", ),
          addIcon: false,
          loadingColor: Colors.brown,
          textButton: Text("Try Again"),
          onButtonPressed: () {
            print("Check your internet and try again"); },
          child: Center(child: const Text("Working",style: TextStyle(fontSize: 20),)),
        ),
      ),
    );
  }
}
