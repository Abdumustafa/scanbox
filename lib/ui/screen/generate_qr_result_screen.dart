import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart'; 
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart'; 
import 'dart:ui' as ui;

class GenerateQrResultScreen extends StatelessWidget {
  final String qrData;

  GenerateQrResultScreen({required this.qrData});

  Future<void> _saveQrImage(BuildContext context, GlobalKey globalKey) async {
    
    PermissionStatus status = await Permission.storage.request();

    
    if (await Permission.manageExternalStorage.isGranted || await Permission.manageExternalStorage.request().isGranted) {
      status = await Permission.manageExternalStorage.request();
    }

    if (status.isGranted) {
      try {
        RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData != null) {
          final result = await ImageGallerySaverPlus.saveImage(
            byteData.buffer.asUint8List(),
            quality: 100,
            name: "qr_code_${DateTime.now().millisecondsSinceEpoch}",
          );

          if (result["isSuccess"] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('QR Code saved to gallery successfully!')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save QR Code.')),
            );
          }
        }
      } catch (e) {
        print('Error saving QR Code: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save QR Code.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Result'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Generated QR Code:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              RepaintBoundary(
                key: globalKey,
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go("/"); 
                },
                child: Text('Home'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveQrImage(context, globalKey),
                child: Text('Save QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

