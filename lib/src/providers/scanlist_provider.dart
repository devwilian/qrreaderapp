import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> listaScans = [];
  String tipoSelected = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;
    if (this.tipoSelected == nuevoScan.tipo) {
      this.listaScans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosScan();
    this.listaScans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.listaScans = [...scans];
    this.tipoSelected = tipo;
    notifyListeners();
  }

  borrarTodo() async {
    print('borrar todo');
    await DBProvider.db.deleteAllScan();
    this.listaScans = [];
    notifyListeners();
  }

  borrarPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    // cargarScans();
    cargarScansPorTipo(this.tipoSelected);
  }
}
