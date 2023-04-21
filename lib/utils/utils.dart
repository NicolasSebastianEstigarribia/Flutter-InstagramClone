import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


pickImage(BuildContext context ,ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  showSnackBar('No selecciono ninguna imagen.');
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

dynamic showSnackBar(String text) {
  final snackBar = SnackBar(
    content: Text(text),
  );
  scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
}