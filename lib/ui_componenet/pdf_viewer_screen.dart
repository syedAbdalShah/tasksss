import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfViewerPath;
  const PdfViewerScreen({required this.pdfViewerPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PDFView(
          filePath: pdfViewerPath,
        ),
      ),
    );
  }
}
