import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/widgets/rotate_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PruebaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      body: Center(
        child: RotateAnimation(
          controller: (controller) => Provider.of<FilterListProvider>(context)
              .controllerRotar = controller,
          child: GestureDetector(
            onTap: () {
              Provider.of<FilterListProvider>(context, listen: false)
                  .controllerRotar
                  .forward(from: 0.0);
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
          Provider.of<FilterListProvider>(context, listen: false)
              .controllerRotar
              .forward(from: 0.0);
        },
      ),
    );
  }
}
