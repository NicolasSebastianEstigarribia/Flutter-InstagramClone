import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


pickImage(BuildContext context ,ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  showSnackBar(context, 'No selecciono ninguna imagen.');
}

dynamic showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}