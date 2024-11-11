import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'network_widget.dart';

void main() {
  runApp(const MyApp());
}

// Main app widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          noInternetText: const Text("Check your internet and try again"),
          addIcon: false,
          loadingColor: Colors.brown,
          textButton: const Text("Try Again"),
          onButtonPressed: () {
            if (kDebugMode) {
              print("Check your internet and try again");
            }
          },
          child: const Center(
            child: Text(
              "Working",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
