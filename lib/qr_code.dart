import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
//import 'package:path_provider_windows/path_provider_windows.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_selector/file_selector.dart';
import 'package:provider/provider.dart';
import 'package:canvanime/provider/DarkThemeProvider.dart';

class Qr_code extends StatelessWidget {
  final Color? elementColor;
  final String? image;
  final int? typeNumber;
  final double? size;
  final String? data;
  final int? errorCorrectLevel;
  final bool? roundEdges;

  Qr_code({this.elementColor, this.image, this.typeNumber, this.size, this.data, this.errorCorrectLevel, this.roundEdges});


  ImageProvider? imagea;

  GlobalKey globalKey = GlobalKey();
  String? _downloadsDirectory = 'Unknown';
  Uint8List? imageInMemory;

// Future method to Capture  the Qr Code
   Future<void> _capturePng() async {

    return new Future.delayed(const Duration(milliseconds: 30), () async {

    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    print(pngBytes);
    _saveFile(pngBytes);
    print('png done');

    });
  }


//void method to Download  the Qr Code
  void _saveFile(Uint8List pngBytes) async {
    String? path = await getSavePath();
    if (path == null) {
      // Operation was canceled by the user.
      return;
    }
    final String fileName = "qrcode";
    final String fileMimeType = 'image/png';
    final XFile imgFile = XFile.fromData(pngBytes, mimeType:fileMimeType, name: fileName);
    await imgFile.saveTo(path);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider?.of<DarkThemeProvider>(context);
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        RepaintBoundary(
        key: globalKey,
        child:
        Column(

          children: <Widget>[
            Container(
                margin: const EdgeInsets.symmetric(vertical: 30.0),

                child:
                Center(
                  //Qr Code widget
                    child: PrettyQr(
                        elementColor: elementColor,
                        image:image== "null"?null:Image.network(image!).image,
                        typeNumber: typeNumber,
                        size: size,
                        data: data,
                        errorCorrectLevel:errorCorrectLevel,
                        roundEdges: roundEdges))
            ),


          ],
        )
    ),
        Container(

          alignment: Alignment.center,
          child: Text(
            "Download the Qr Code",
            style: TextStyle(fontWeight: FontWeight.bold,
              color:  themeProvider.darkTheme?Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(68,44,46, 1.0),
              fontSize: 16.0,
              fontFamily: 'Goldman',
            ),
          ),
          padding: EdgeInsets.all(3.0),
        ),
        FloatingActionButton(
          onPressed: _capturePng,
          tooltip: 'Save',
          child: Icon(Icons.save_rounded),
        ),


      ],
    );




  }
}