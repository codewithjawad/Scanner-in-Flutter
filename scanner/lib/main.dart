import 'package:flutter/material.dart';
import 'package:scanner/Qrscanner.dart';
import 'package:scanner/resultscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.white, elevation: 2.0)),
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      home: Qrscanner(),
    );
  }
}
