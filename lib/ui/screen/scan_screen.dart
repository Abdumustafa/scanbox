import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerScreen extends StatefulWidget {
  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  final ValueNotifier<bool> isTorchOn = ValueNotifier<bool>(false);
  bool hasScanned = false;

  @override
  void initState() {
    super.initState();
    checkCameraPermission();
  }

  Future<void> checkCameraPermission() async {
    while (true) {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        break;
      } else {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('إذن الكاميرا مطلوب'),
            content: Text(
                'تحتاج إلى منح إذن الوصول إلى الكاميرا لاستخدام ميزة المسح.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('المحاولة مرة أخرى'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('إلغاء'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    isTorchOn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff3b0356),
        title: const Text.rich(
          TextSpan(
            text: 'Scan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: 'B',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Color(0xfff4a8b6))),
              TextSpan(
                text: 'ox',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: isTorchOn,
              builder: (context, state, child) {
                return Icon(
                  state ? Icons.flash_on : Icons.flash_off,
                  color: state
                      ? Colors.amber
                      : const Color.fromARGB(255, 238, 235, 235),
                  size: 30,
                );
              },
            ),
            onPressed: () {
              cameraController.toggleTorch();
              isTorchOn.value = !isTorchOn.value;
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null && !hasScanned) {
                    hasScanned = true;
                    cameraController.stop();

                    context.go('/result', extra: barcode.rawValue!);
                    break;
                  }
                }
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Scan QR/Barcode',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(2, 2),
                      blurRadius: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const SizedBox(),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'مسح رمز الاستجابة السريعة ضوئياً',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    print('Scan from photo');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'مسح الرمز ضوئياً من صورة',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
