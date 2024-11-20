import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Resultscreen extends StatelessWidget {
  final String code;
  final Function() closescreen;

  const Resultscreen(
      {super.key, required this.closescreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black12,
              )),
          title: const Text(
            'Qr Scanner',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 2),
          ),
        ),
        body: Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImageView(
                  data: code,
                  size: 150,
                  version: QrVersions.auto,
                ),
                const Text(
                  'Scanned Result',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 2),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  code,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 2),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 100,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      'Copy',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
