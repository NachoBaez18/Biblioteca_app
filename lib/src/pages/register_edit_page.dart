import 'package:biblioteca_app/src/ui/input_decoration.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegisterEditPage extends StatelessWidget {
  final String? url = null;
  const RegisterEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const ImageRegisterEdit(),
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
                            source: ImageSource.camera, imageQuality: 100);

                        if (pickeFile == null) {
                          print('No selecciono nada');
                          return;
                        }
                        print('Tenemos imagen ${pickeFile.path}');

                        // productService
                        //     .updateSelectedProductImage(pickeFile.path);
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              _producrForm()
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
            child: //productService.isSaving
                //? CircularProgressIndicator(color: Colors.white)
                Icon(Icons.save_alt_outlined),
            onPressed: () {}
            //  productService.isSaving
            //     ? null
            //     : () async {
            //         if (!proudctFrom.isValidFrom()) return;

            //         final String? imageUrl = await productService.uploadImage();
            //         if (imageUrl != null) proudctFrom.product.picture = imageUrl;

            //         await productService.saveOrCreate(proudctFrom.product);
            //       },
            ));
  }
}

class _producrForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      'Administracion',
      'History',
      'Fisica',
      'Psicologia',
      'Nutricion',
      'Medicina',
      'Enfermeria',
      'Odontologia',
      'Contaduria',
    ];

    String? _selectedVal = 'History';
    // final productForm = Provider.of<ProductFormProvider>(context);

    //final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            //  key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  // initialValue: product.name,
                  // onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del Libro', labelText: 'Libro'),
                ),
                const SizedBox(height: 30),
                DropdownButtonFormField(
                  value: _selectedVal,
                  items: items
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    print(value);
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.blue,
                  ),
                  decoration:
                      const InputDecoration(labelText: 'Materia del libro'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  //  initialValue: '${product.price}',
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(
                  //       RegExp(r'^(\d+)?\.?\d{0,2}'))
                  // ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      // product.price = 0;
                    } else {
                      // product.price = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Pequeña descripcion del libro',
                      labelText: 'Descripción'),
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
