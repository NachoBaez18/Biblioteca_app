import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/models/usuario.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:biblioteca_app/src/ui/alertOperacional.dart';
import 'package:biblioteca_app/src/ui/alertas_new.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ListView/filter_provider.dart';

class RegisterEditUser extends StatefulWidget {
  const RegisterEditUser({super.key});

  @override
  State<RegisterEditUser> createState() => _RegisterEditUserState();
}

class _RegisterEditUserState extends State<RegisterEditUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  bool onPressButon = false;
  List<Map<String, String>> tipos = [
    {'descripcion': 'Seleccione tipo de usuario', 'valor': ''},
    {'descripcion': 'Administrador', 'valor': 'administrador'},
    {'descripcion': 'Usuario', 'valor': 'alumno'}
  ];
  @override
  void initState() {
    _nombreController.text = '';
    _correoController.text = '';
    _telefonoController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final provider = Provider.of<FilterListProvider>(context);

    final CarreraResponse carrera = args['carrera'];
    final Usuario usuario = args['usuario'];
    if (usuario.nombre != null) {
      _correoController.text = usuario.email!;
      _nombreController.text = usuario.nombre!;
      _telefonoController.text = usuario.telefono!;
    }

    return Scaffold(
      appBar: appBarDesing(
          'Usuario',
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
                usuario.nombre != null ? 'Edición' : 'Registro',
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
                    TextFormField(
                      // initialValue: _correo,
                      controller: _correoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Correo',
                        border: const OutlineInputBorder(),
                        errorText:
                            _correoController.text.isEmpty && onPressButon
                                ? 'Campo requerido'
                                : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _telefonoController,
                      //initialValue: _telefono,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Telefono',
                        border: const OutlineInputBorder(),
                        errorText:
                            _telefonoController.text.isEmpty && onPressButon
                                ? 'Campo requerido'
                                : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Seleccione una opcion';
                        } else {
                          return null;
                        }
                      },
                      isExpanded: true,
                      value: provider.tipo,
                      onChanged: (newValue) {
                        provider.tipo = newValue!.toString();
                      },
                      items: tipos
                          .map((e) => DropdownMenuItem(
                                value: e['valor'],
                                child: Text(e['descripcion']!),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            value == 'Seleccione una carrera') {
                          return 'Seleccione una opcion';
                        } else {
                          return null;
                        }
                      },
                      isExpanded: true,
                      value: provider.carrera,
                      onChanged: (newValue) {
                        print(newValue);

                        provider.carrera = newValue!.toString();
                      },
                      items: carrera.carreras.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.nombre,
                          child: Text(e.nombre),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          // Establecer el tamaño del botón
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 50)),
                          // Otras propiedades de estilo que puedes ajustar
                          backgroundColor: MaterialStateProperty.all(
                              usuario.nombre != null
                                  ? Colors.orangeAccent
                                  : Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
                      onPressed: usuario.nombre == null
                          ? _createUser
                          : () async {
                              _editUser(usuario.uid!);
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: usuario.nombre != null
                            ? const [
                                Icon(Icons.edit),
                                SizedBox(width: 10),
                                Text('Editar'),
                              ]
                            : const [
                                Icon(Icons.person_add_alt),
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
    final provider = Provider.of<FilterListProvider>(context, listen: false);
    onPressButon = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      progresIndicatorModal(context);
      final response = await UsuarioServices().registrar(
          _nombreController.text,
          _telefonoController.text,
          provider.carrera,
          provider.tipo,
          _correoController.text);
      navigator.pop();
      if (response['ok']) {
        if (context.mounted) {
          AlertasNew().alertaCorrectaNavegatoria(
              context, 'Usuario Registrado Correctamente', 'home');
        }
      } else {
        if (context.mounted) {
          AlertasNew().alertaInCorrectaNavegatoria(
              context,
              response['msg'] ?? 'Ocurrio un error al tratar de registrar',
              'home');
        }
      }

      // Realizar acciones si el formulario es válido
    }
  }

  Future _editUser(String uid) async {
    final provider = Provider.of<FilterListProvider>(context, listen: false);
    onPressButon = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      progresIndicatorModal(context);
      print(provider.carrera);
      // print(
      //     '$uid, $_nombre, $_telefono, $_selectedCarrera, $_selectedTipo, $_correo');
      final response = await UsuarioServices().editar(
          uid,
          _nombreController.text,
          _telefonoController.text,
          provider.carrera,
          provider.tipo,
          _correoController.text);
      navigator.pop();
      print(response);
      if (!response['error']) {
        if (context.mounted) {
          AlertasNew().alertaCorrectaNavegatoria(
              context, 'Usuario Editado Correctamente', 'home');
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
