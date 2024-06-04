import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Color? loadingColor;
   Loading({super.key,this.loadingColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: loadingColor??Colors.white,
        size: 50,
      ),
    );
  }
}
