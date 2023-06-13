import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final String imageUrl;

  const ImageNetwork({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit
          .cover, // Ajusta la imagen para cubrir todo el espacio disponible
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child; // La imagen ha terminado de cargar, se muestra normalmente
        }
        return const Center(
          child:
              CircularProgressIndicator(), // Muestra un indicador de carga mientras la imagen se está descargando
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Text(
            'Error al cargar la imagen'); // Muestra un mensaje de error si no se puede cargar la imagen
      },
    );
  }
}
