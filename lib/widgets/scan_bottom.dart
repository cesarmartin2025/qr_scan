import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/screens/scan_screen.dart';
import 'package:qr_scan/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed:  () async {
        print('Botó polsat!');

        final String? valorEscaneado = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const ScannerScreen()),
        );

        if (valorEscaneado == null) {
          return; 
        }
        
        
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

       // String para pruebas http -> String valorEscaneado = "https://paucasesnovescifp.cat";

        // String para pruebas geo -> String valorEscaneado = "geo:39.7259514,2.9136474";
        
        ScanModel nuevoScan = ScanModel(valor: valorEscaneado);
        scanListProvider.nuevoScan(valorEscaneado); 

        launchURL(context, nuevoScan);
      },
    );
  }
}
