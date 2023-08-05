import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/services/carrera_services.dart';
import 'package:flutter/material.dart';

import '../ui/alertOperacional.dart';
import '../ui/alertas_new.dart';
import '../widgets/widgets.dart';

class RegisterEditCarrera extends StatefulWidget {
  const RegisterEditCarrera({super.key});

  @override
  State<RegisterEditCarrera> createState() => _RegisterEditCarreraState();
}

class _RegisterEditCarreraState extends State<RegisterEditCarrera> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  bool onPressButon = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;

    final Carrera carrera = args['carrera'];
    if (carrera.nombre != '') {
      _nombreController.text = carrera.nombre;
    }

    return Scaffold(
      appBar: appBarDesing(
          'Carrera',
          [
            const Color(0xFFd6da9e), // Color del lado izquierdo del gradiente
            const Color(0xFFadb039),
          ],
          false,
          null),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                carrera.nombre != '' ? 'Edición' : 'Registro',
                style: const TextStyle(fontSize: 25),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      // initialValue: _nombre,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: const OutlineInputBorder(),
                        errorText:
                            _nombreController.text.isEmpty && onPressButon
                                ? 'Campo requerido'
                                : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          // Establecer el tamaño del botón
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 50)),
                          // Otras propiedades de estilo que puedes ajustar
                          backgroundColor: MaterialStateProperty.all(
                              carrera.nombre != ''
                                  ? Colors.orangeAccent
                                  : Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
                      onPressed: carrera.nombre == ''
                          ? _createUser
                          : () async {
                              _editUser(carrera.uid);
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: carrera.nombre != ''
                            ? const [
                                Icon(Icons.edit),
                                SizedBox(width: 10),
                                Text('Editar'),
                              ]
                            : const [
                                Icon(Icons.school),
                                SizedBox(width: 10),
                                Text('Registrar'),
                              ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _createUser() async {
    onPressButon = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      progresIndicatorModal(context);
      final response = await CarreraServices().registrar(
        _nombreController.text,
      );
      navigator.pop();
      if (!response['error']) {
        if (context.mounted) {
          AlertasNew().alertaCorrectaNavegatoria(
              context, 'Carrera Registrado Correctamente', 'home');
        }
      } else {
        if (context.mounted) {
          AlertasNew().alertaInCorrectaNavegatoria(
              context,
              response['mensaje'] ?? 'Ocurrio un error al tratar de registrar',
              'home');
        }
      }

      // Realizar acciones si el formulario es válido
    }
  }

  Future _editUser(String uid) async {
    onPressButon = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      progresIndicatorModal(context);
      final response = await CarreraServices().editar(
        uid,
        _nombreController.text,
      );
      navigator.pop();
      if (!response['error']) {
        if (context.mounted) {
          AlertasNew().alertaCorrectaNavegatoria(
              context, 'Carrera Editado Correctamente', 'home');
        }
      } else {
        if (context.mounted) {
          AlertasNew().alertaInCorrectaNavegatoria(
              context,
              response['mensaje'] ?? 'Ocurrio un error al tratar de editar',
              'home');
        }
      }

      // Realizar acciones si el formulario es válido
    }
  }
}
