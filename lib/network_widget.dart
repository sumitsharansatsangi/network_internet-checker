import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'loading.dart';

/// The ConnectivityWidget is a reusable component that handles connectivity changes.
class ConnectivityWidget extends StatefulWidget {
  final Widget child;
  final void Function()? onButtonPressed;
  final Text noInternetText;
  final Widget? icon;
  final bool addIcon;
  final Text textButton;
  final Color? loadingColor;
  final Color? backgroundColor;

  /// Constructor to initialize the widget with a child and an optional current route.
  const ConnectivityWidget(
      {super.key,
      this.loadingColor,
      required this.child,
      required this.textButton,
      required this.noInternetText,
      required this.addIcon,
      this.icon,
      this.backgroundColor,
      required this.onButtonPressed});

  @override
  _ConnectivityWidgetState createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  var networkConnectivity = "";
  Key _childKey = UniqueKey();
  @override
  void initState() {
    super.initState();

    /// Initialize connectivity check on widget creation.
    initConnectivity();

    /// Listen for connectivity changes.
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    /// Cancel the subscription when the widget is disposed.
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Display a different screen if there is no connectivity.
    return networkConnectivity == "ConnectivityResult.none"
        ? Screen2(
            onButtonPressed: widget.onButtonPressed,
            backgroundColor: widget.backgroundColor,
            noInternetText: widget.noInternetText,
            addIcon: widget.addIcon,
            initConnectivity: initConnectivity,
            textButton: widget.textButton,
            loadingColor: widget.loadingColor,
          )
        : KeyedSubtree(
            key: _childKey,
            child: widget.child,
          );
  }

  /// Method to initialize connectivity check.
  Future<void> initConnectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
    }
  }

  /// Method to update connection status.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
      networkConnectivity = _connectionStatus.contains(ConnectivityResult.none)
          ? "ConnectivityResult.none"
          : "";
    });

    if (_connectionStatus.contains(ConnectivityResult.none)) {
    } else {
      _resetChildState();
    }
  }

  /// Method to reset the child widget's state.
  void _resetChildState() {
    setState(() {
      _childKey = UniqueKey();
    });
  }
}

/// Screen2 widget displays when there is no internet connection.
class Screen2 extends StatefulWidget {
  final void Function()? onButtonPressed;
  final Future<void> Function() initConnectivity;
  final Text noInternetText;

  final Widget? icon;
  final bool addIcon;
  final Text textButton;
  final Color? loadingColor;
  final Color? backgroundColor;

  /// Constructor to initialize Screen2 with onRefresh and onPressed callbacks.
  const Screen2(
      {super.key,
      required this.onButtonPressed,
      required this.textButton,
      required this.noInternetText,
      required this.addIcon,
      this.backgroundColor,
      required this.initConnectivity,
      this.icon,
      this.loadingColor});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),

            ///  Uncomment and add your image asset or any widget you want to use for your connection
            widget.addIcon
                ? widget.icon!
                : Image.asset("assets/no_network.jpg"),
            const SizedBox(height: 50),
            widget.noInternetText,
            const SizedBox(height: 30),
            isLoading
                ? Loading(
                    loadingColor: widget.loadingColor,
                  )
                : TextButton(
                    onPressed: () async {
                      widget.onButtonPressed!();
                      setState(() {
                        isLoading = true;
                      });
                      await widget.initConnectivity();
                      Future.delayed(Duration(seconds: 5), () {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                    child: widget.textButton,
                  ),
          ],
        ),
      ),
    );
  }
}
