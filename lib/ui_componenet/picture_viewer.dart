import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

class PictureViewer extends StatelessWidget {
  final String imagePath;
  const PictureViewer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: PhotoView(
        imageProvider: FileImage(File(imagePath)),
      ),
    ));
  }
}
