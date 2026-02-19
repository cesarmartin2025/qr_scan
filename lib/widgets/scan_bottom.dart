import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () {
        print('Botó polsat!');

        //ScanModel nuevoScan = ScanModel(valor:"https://paucasesnovescifp.cat");

       // DbProvider.db.insertScan(nuevoScan);

        String valor = "https://paucasesnovescifp.cat";

        String valorGeo = "geo:123124312414";

        final scanListProvider = Provider.of<ScanListProvider>(context,listen:false);

        scanListProvider.nuevoScan(valorGeo);
        scanListProvider.nuevoScan(valor);
      },
    );
  }
}
