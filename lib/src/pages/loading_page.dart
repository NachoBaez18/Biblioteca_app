import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.topCenter,
            colors: [
              Color(0xff0a4e93),
              Color(0xff1a3359),
            ],
          )),
      child: ElasticIn(
        duration: const Duration(seconds: 2),
        child: Container(
          margin: const EdgeInsets.only(right: 40, left: 40),
          child: const Image(
            image: AssetImage('assets/logoUni.png'),
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
