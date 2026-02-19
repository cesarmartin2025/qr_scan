import 'package:flutter/foundation.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];
  String tiposSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor)async {
    final nuevoScan = ScanModel(valor: valor);

    final id = await DbProvider.db.insertScan(nuevoScan);

    nuevoScan.id=id;

    if(nuevoScan.tipos==tiposSeleccionado){
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async{
    final scans = await DbProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipos(String tipos) async{
    final scansPorTipos = await DbProvider.db.getScanByTipos(tipos);

    this.scans = [...scansPorTipos];
    this.tiposSeleccionado = tipos;

    notifyListeners();


  }

  borrarTodosLosScans() async{
    await DbProvider.db.deleteAllScans();

    this.scans=[];

    notifyListeners();
  }

  borrarPorId(int id) async{
    await DbProvider.db.deleteScanById(id);

    //Volvemos a cargar los datos de la base de datos despues de borrar el id

    this.cargarScansPorTipos(this.tiposSeleccionado);
  }



}