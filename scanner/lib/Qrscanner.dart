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
      backgroundColor: const Color(0xFFF5F5F5), // Off-white background

      appBar: AppBar(
        backgroundColor: Color(0xFF00BF6D), // Green AppBar background
        iconTheme:
            const IconThemeData(color: Colors.white), // Set icons to white
        titleTextStyle: const TextStyle(
            color: Colors.white, // White text color for the title
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 2),
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
              color: isFlashOn
                  ? Colors.white
                  : Colors.white, // Flash icon in white
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
              color: isCameraOn
                  ? Colors.white
                  : Colors.white, // Camera switch icon in white
            ),
          ),
        ],
        centerTitle: true,
        title: const Text('Qr Scanner'),
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
                  'Developed By Quantaflix',
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
