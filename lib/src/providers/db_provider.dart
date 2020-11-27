import 'dart:io';

import 'package:qrreaderapp/src/models/qrscan_model.dart';
export 'package:qrreaderapp/src/models/qrscan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();
  Future<Database> get dataBase async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE Scans (
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
        ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel scanModel) async {
    final db = await dataBase;
    final res = await db.rawInsert("insert into Scans (id, tipo, valor) values "
        "${scanModel.id}, '${scanModel.tipo}', '${scanModel.valor}')");
    return res;
  }

  Future<int> nuevoScan(ScanModel scanModel) async {
    final db = await dataBase;
    final res = db.insert('Scans', scanModel.toJson());
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await dataBase;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScan() async {
    final db = await dataBase;
    final res = await db.query('Scans');
    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await dataBase;
    final res = await db.rawQuery("select * from Scans where tipo = '$tipo'");
    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await dataBase;
    final res = await db.update('Scans', scanModel.toJson(),
        where: 'id=?', whereArgs: [scanModel.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await dataBase;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await dataBase;
    final res = await db.rawDelete("delete from Scans");
    return res;
  }
}
