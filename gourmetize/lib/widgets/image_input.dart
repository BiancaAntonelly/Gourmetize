import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatelessWidget {
  final String? initialUrl;
  final File? value;
  final void Function(File value) onChange;
  final ImagePicker _picker = ImagePicker();

  ImageInput({this.initialUrl, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    takePicture() async {
      XFile? imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (imageFile == null) return;

      File file = File(imageFile.path);

      onChange(file);
    }

    pickImage() async {
      XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

      if (imageFile == null) return;

      File file = File(imageFile.path);

      onChange(file);
    }

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: value != null
              ? Image.file(
                  value!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : initialUrl != null
                  ? Image.network(
                      initialUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      alignment: Alignment.center,
                    )
                  : Text(
                      'Selecione uma imagem',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: takePicture,
              icon: Icon(Icons.camera),
              label: Text('Tirar Foto'),
            ),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.photo),
              label: Text('Buscar na Galeria'),
            ),
          ],
        ),
      ],
    );
  }
}
