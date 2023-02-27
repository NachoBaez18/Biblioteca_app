import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _TituloSaludo(),
                  Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class _TituloSaludo extends StatelessWidget {
  const _TituloSaludo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hola,',
            style: TextStyle(fontSize: 30, fontFamily: 'RobotoMono'),
          ),
          SizedBox(height: 15),
          Text(
            'Bienvenido',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
