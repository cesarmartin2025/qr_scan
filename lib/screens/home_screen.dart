import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
             final instancia = Provider.of<ScanListProvider>(context,listen: false);
             instancia.borrarTodosLosScans();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOption;

    final scanListProvider = Provider.of<ScanListProvider>(context);

    // Creacion BDD no definitiva
   // DbProvider.db.database;

   // DbProvider.db.getAllScans().then(print);

    

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipos('geo');
        return MapasScreen();

      case 1:
        scanListProvider.cargarScansPorTipos('http');
        return DireccionsScreen();

      default:
        scanListProvider.cargarScansPorTipos('geo');
        return MapasScreen();
    }
  }
}
