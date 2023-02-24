
import 'package:biblioteca_app/src/widgets/rotate_widget.dart';
import 'package:flutter/material.dart';


class PruebaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotateAnimation(
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
      ),
    );
  }
}
