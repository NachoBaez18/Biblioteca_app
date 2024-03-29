import 'package:biblioteca_app/src/models/libro.dart';
import 'package:flutter/material.dart';

class LibroFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Libro libro;
  bool isSaving = false;

  LibroFormProvider(this.libro);

  bool isValidFrom() {
    return formKey.currentState?.validate() ?? false;
  }
}
