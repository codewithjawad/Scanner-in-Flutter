import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner/resultscreen.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class Qrscanner extends StatefulWidget {
  const Qrscanner({super.key});

  @override
  State<Qrscanner> createState() => _QrscannerState();
}

class _QrscannerState extends State<Qrscanner> {
  bool scanCompleted = false;
  bool isCameraOn = false;
  bool isFlashOn = false;
  late String code; 

  MobileScannerController mobScannerController = MobileScannerController();

  void closeScreen() {
    setState(() {
      scanCompleted = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              mobScannerController.toggleTorch();
            },
            icon: Icon(
              Icons.flash_on,
              color: isFlashOn ? Colors.blue : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isCameraOn = !isCameraOn;
              });
              mobScannerController.switchCamera();
            },
            icon: Icon(
              Icons.camera_front,
              color: isCameraOn ? Colors.blue : Colors.grey,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Qr Scanner',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 2),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Place Qr code in the area',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 2),
                ),
                Text('Scanning will Start Automatically')
              ],
            )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: mobScannerController,
                    onDetect: (barcode) {
                      if (!scanCompleted) {
                        setState(() {
                          code = barcode.raw.toString();
                          scanCompleted = true;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Resultscreen(
                                code: code, closescreen: closeScreen),
                          ),
                        );
                      }
                    },
                  ),
                  QRScannerOverlay(
                    overlayColor: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Developed By Jawwad Ahmed',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
