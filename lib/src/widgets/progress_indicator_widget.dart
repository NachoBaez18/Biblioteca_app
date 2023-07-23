import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgresIndicatorMe extends StatelessWidget {
  const ProgresIndicatorMe({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: const SpinKitThreeBounce(
          color: Colors.blue,
        ),
        onWillPop: () async => false);
  }
}
