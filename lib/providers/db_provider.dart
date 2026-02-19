import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database? _database;

  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Obtenemos el Path

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    print(path);

    //Creación BDD

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipos TEXT,
          valor TEXT
          )
      ''');
      },
    );
  }

  Future<int> insertRawScan(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipos = nuevoScan.tipos;
    final valor = nuevoScan.valor;

    final db = await database;

    final resultado = await db.rawInsert('''
          INSERT INTO Scans(id,tipos,valor)
          VALUES($id,$tipos,$valor)
''');
    return resultado;
  }

  Future<int> insertScan(ScanModel nuevoScan) async{
    final db = await database;

    final resultado = await db.insert('Scans', nuevoScan.toMap());
    print(resultado);

    return resultado;

  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final resultado = await db.query('Scans');

    return resultado.isNotEmpty ? resultado.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  Future<ScanModel?> getScanById(int id) async{
    final db = await database;
    final resultado = await db.query('Scans',where : 'id=?',whereArgs: [id]);

    if(resultado.isNotEmpty){
      return ScanModel.fromMap(resultado.first);
    }
    return null;
  }

  Future<List<ScanModel>> getScanByTipos(String tipos) async {
    final db = await database;

    final resultado = await db.query('Scans',where: 'tipos=?',whereArgs: [tipos]);

    return resultado.isNotEmpty ? resultado.map((e) => ScanModel.fromMap(e)).toList(): [];

  }  

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    
    final resultado = db.update('Scans', nuevoScan.toMap(), where: 'id=?',whereArgs: [nuevoScan.id]);

    return resultado;
  }

  Future<int> deleteAllScans() async {
    final db = await database;

    final resultado = db.rawDelete('''DELETE FROM Scans''');

    return resultado;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;

    final resultado = db.delete('Scans',where: 'id=?',whereArgs: [id]);

    return resultado;
  }



  Future<void> deleteDatabaseFile() async {
    
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
    await deleteDatabase(path);
    
    print('Base de datos eliminada en: $path');
  }

}

