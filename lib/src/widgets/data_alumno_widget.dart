import 'package:flutter/material.dart';

import '../models/usuario.dart';

class DataAlumno extends StatelessWidget {
  final Usuario usuario;
  final String accion;
  const DataAlumno({super.key, required this.usuario, required this.accion});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color.fromARGB(255, 212, 145, 148)),
            child: Center(
              child: Text(
                '${usuario.nombre![0].toUpperCase()}${usuario.nombre![1].toUpperCase()}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                usuario.nombre!,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Text(
                '${usuario.carrera} ---- ${usuario.semestre} Semestre',
                style: const TextStyle(fontSize: 16, color: Colors.black45),
              ),
              const SizedBox(height: 5),
              const Text('Sede Caacupe',
                  style: TextStyle(fontSize: 16, color: Colors.black45)),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16.0, color: Colors.black45),
                  children: [
                    const TextSpan(text: 'Accion a realizar: '),
                    TextSpan(
                        text: accion,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
