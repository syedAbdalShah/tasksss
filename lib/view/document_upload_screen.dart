import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:productbox_flutter_exercise/constants/myButton.dart';
import 'package:productbox_flutter_exercise/constants/theme_data.dart';

import 'package:productbox_flutter_exercise/ui_componenet/pdf_viewer_screen.dart';
import 'package:productbox_flutter_exercise/ui_componenet/picture_viewer.dart';
import 'package:sizer/sizer.dart';

class DocumentUploadedScreen extends StatefulWidget {
  @override
  State<DocumentUploadedScreen> createState() => _DocumentUploadedScreenState();
}

class _DocumentUploadedScreenState extends State<DocumentUploadedScreen> {
  File? selectedImage;
  File? drivingLicence;
  File? certificate;
  File? passport;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyThemeData.themeData.backgroundColor,
      body: Center(
        child: Column(
          children: [
            verticalGap(size, 0.05),
            buildText(text: 'Upload Documents'),
            verticalGap(size, 0.05),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              validateContainer(
                  size,
                  selectedImage != null
                      ? MyThemeData.themeData.primaryColor
                      : Colors.grey),
              validateContainer(
                  size,
                  drivingLicence != null
                      ? MyThemeData.themeData.primaryColor
                      : Colors.grey),
              validateContainer(
                  size,
                  certificate != null
                      ? MyThemeData.themeData.primaryColor
                      : Colors.grey),
              validateContainer(
                  size,
                  passport != null
                      ? MyThemeData.themeData.primaryColor
                      : Colors.grey),
            ]),
            verticalGap(size, 0.05),
            buildFilePick(
                text: 'Profile Picture',
                size: size,
                child: selectedImage == null
                    ? Text('pick file')
                    : Image.file(selectedImage!),
                ontap: pickImage),
            verticalGap(
              size,
              0.02,
            ),
            buildFilePick(
                text: 'Driving License',
                size: size,
                child: drivingLicence == null
                    ? Text('pick file')
                    : Image(image: AssetImage('assets/pdf_image.jpg')),
                ontap: drivingLincencepdfPicker),
            verticalGap(size, 0.02),
            buildFilePick(
                text: 'Certificate',
                size: size,
                child: certificate == null
                    ? Text('pick file')
                    : Image(image: AssetImage('assets/pdf_image.jpg')),
                ontap: certificatepdfPicker),
            verticalGap(size, 0.02),
            buildFilePick(
                text: 'Passport',
                size: size,
                child: passport == null
                    ? Text('pick file')
                    : Image(image: AssetImage('assets/pdf_image.jpg')),
                ontap: passportpdfPicker),
            verticalGap(size, 0.05),
            Opacity(
              opacity: enableButton() ? 1 : 0.3,
              child: MyButton(
                widget: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container validateContainer(Size size, Color color) {
    return Container(
      width: size.width * 0.17,
      height: size.height * 0.01,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
    );
  }

  Container buildFilePick(
      {required Size size,
      required String text,
      Function()? ontap,
      Widget? child}) {
    return Container(
      alignment: Alignment.center,
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
          InkWell(
              onTap: ontap,
              child: Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.02),
                  width: size.width * 0.12,
                  height: size.height,
                  child: child)),
        ],
      ),
    );
  }

  Text buildText({required String text, double? fontSize}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: fontSize == null ? 28.sp : fontSize),
    );
  }

  drivingLincencepdfPicker() async {
    if (drivingLicence == null) {
      final result = await pickFile(['pdf']);
      if (result != null) {
        setState(() {
          drivingLicence = File(result.files.first.path!);
        });
      }
    } else {
      navigatToPdfViewerPage(drivingLicence!.path);
    }
  }

  certificatepdfPicker() async {
    if (certificate == null) {
      final result = await pickFile(['pdf']);
      if (result != null) {
        setState(() {
          certificate = File(result.files.first.path!);
        });
      }
    } else {
      navigatToPdfViewerPage(certificate!.path);
    }
  }

  passportpdfPicker() async {
    if (passport == null) {
      final result = await pickFile(['pdf']);
      if (result != null) {
        setState(() {
          passport = File(result.files.first.path!);
        });
      }
    } else {
      navigatToPdfViewerPage(passport!.path);
    }
  }

  navigatToPdfViewerPage(String pdfPath) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PdfViewerScreen(pdfViewerPath: pdfPath)));
  }

  pickImage() async {
    if (selectedImage == null) {
      final result = await pickFile(['jpg', 'png']);
      if (result != null) {
        setState(() {
          selectedImage = File(result.files.first.path!);
        });
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => PictureViewer(imagePath: selectedImage!.path)));
    }
  }

  Future<FilePickerResult> pickFile(List<String> extensionSupport) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: extensionSupport);
    return result!;
  }

  bool enableButton() {
    if (selectedImage != null &&
        drivingLicence != null &&
        certificate != null &&
        passport != null) {
      return true;
    } else {
      return false;
    }
  }

  SizedBox verticalGap(Size size, double customSize) {
    return SizedBox(height: size.height * customSize);
  }
}
