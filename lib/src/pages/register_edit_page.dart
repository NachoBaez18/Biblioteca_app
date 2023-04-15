import 'dart:convert';

import 'package:biblioteca_app/src/models/registerUpdateDeleteResponse.dart';
import 'package:biblioteca_app/src/provider/data_provider.dart';
import 'package:biblioteca_app/src/provider/provider.dart';

import 'package:biblioteca_app/src/services/libros_services.dart';

import 'package:biblioteca_app/src/ui/alertas_new.dart';
import 'package:biblioteca_app/src/ui/input_decoration.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart' as provider;

class RegisterEditPage extends StatelessWidget {
  final String? url = null;
  const RegisterEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final libroServices = provider.Provider.of<LibroServices>(context);
    return provider.ChangeNotifierProvider(
        create: (_) => LibroFormProvider(libroServices.selectedLibro),
        child: _LibroScreenBody(libroServices: libroServices));
  }
}

class _LibroScreenBody extends StatelessWidget {
  const _LibroScreenBody({
    super.key,
    required this.libroServices,
  });

  final LibroServices libroServices;

  @override
  Widget build(BuildContext context) {
    final libroForm = provider.Provider.of<LibroFormProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  ImageRegisterEdit(libroServices.selectedLibro.imagen),
                  Positioned(
                      top: 60,
                      left: 20,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      )),
                  Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final PickedFile? pickeFile = await picker.getImage(
                            source: ImageSource.gallery, imageQuality: 100);

                        if (pickeFile == null) {
                          return;
                        }

                        libroServices
                            .updateSelectedProductImage(pickeFile.path);
                      },
                      icon: const Icon(
                        Icons.archive_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              _ProducrForm()
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: libroForm.isSaving
              ? null
              : () async {
                  if (!libroForm.isValidFrom()) return;

                  final String? imageUrl = await libroServices.uploadImage();

                  if (imageUrl != null) libroForm.libro.imagen = imageUrl;
                  final OperationResponse libroResponse;

                  libroResponse =
                      await libroServices.saveOrCreate(libroForm.libro);

                  if (context.mounted) {
                    if (!libroResponse.error) {
                      AlertasNew().alertaCorrectaNavegatoria(
                          context, libroResponse.mensaje, 'books_list');
                    } else {
                      AlertasNew().alertaCorrectaNavegatoria(
                          context, libroResponse.mensaje, 'books_list');
                    }
                  }
                },
          child: libroForm.isSaving
              ? const CircularProgressIndicator(color: Colors.white)
              : const Icon(Icons.save_alt_outlined),
        ));
  }
}

class _ProducrForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final libroForm = provider.Provider.of<LibroFormProvider>(context);
    final libro = libroForm.libro;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: libroForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: libro.nombre,
                  onChanged: (value) => libro.nombre = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                    return null;
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del Libro', labelText: 'Libro'),
                ),
                const SizedBox(height: 30),
                const _ListCarreras(),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: libro.nombre,
                  onChanged: (value) => libro.descripcion = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La descripcion es obligatoria';
                    }
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Descripción del Libro',
                      labelText: 'Descripción'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: libro.creador,
                  onChanged: (value) => libro.creador = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El autor es obligatoria';
                    }
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Autor del Libro', labelText: 'Autor'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  initialValue: libro.cantidad.toString(),
                  onChanged: (value) {
                    if (value == '') {
                      libro.cantidad = 0;
                    } else {
                      libro.cantidad = int.parse(value);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La cantidad es obligatoria';
                    }
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Cantidad Libro', labelText: 'Cantidad'),
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5))
          ]);
}

class _ListCarreras extends ConsumerWidget {
  const _ListCarreras({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refcarreras = ref.watch(carreraDataProvider).value;
    final libroForm = provider.Provider.of<LibroFormProvider>(context);
    final isEdit = provider.Provider.of<FilterListProvider>(context);
    final libro = libroForm.libro;
    return DropdownButtonFormField(
      value: isEdit.isEdit ? libro.carrera : refcarreras!.carreras.first.nombre,
      items: refcarreras?.carreras
          .map(
            (e) => DropdownMenuItem(
              value: e.nombre,
              child: Text(e.nombre),
            ),
          )
          .toList(),
      onChanged: (value) {
        libro.carrera = value!;
      },
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.blue,
      ),
      decoration: const InputDecoration(labelText: 'Materia del libro'),
    );
  }
}
