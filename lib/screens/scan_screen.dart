import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanea un código QR'),
      ),
      body: MobileScanner(
        onDetect: (result) {
          //Coge el atributo List<Barcode> de la clase BarcodeCapture
          final List<Barcode> barcodes = result.barcodes;
          
          if (barcodes.isNotEmpty) {
            //Saca el string barcode de ese codigo QR(barcode).
            final String? barcode = barcodes.first.rawValue;
            
            if (barcode != null) {
              //Cierra la pantalla de la camara y devuelve al widget ScanButton el string barcode
              Navigator.pop(context, barcode);
            }
          }
        },
      ),
    );
  }
}