// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImagePreview extends StatelessWidget {

  const ImagePreview({required this.isImageSelected,required this.imageFile});
  final bool isImageSelected;
  final File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[(isImageSelected)? Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: FileImage(imageFile!),
        ),
      ),
    ):
      Text("No image uploaded"),
      ]
    )

    );
  }
}
