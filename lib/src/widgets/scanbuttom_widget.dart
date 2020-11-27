import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/src/common/util.dart';
import 'package:qrreaderapp/src/models/qrscan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/providers/scanlist_provider.dart';

class ScanButtom extends StatelessWidget {
  const ScanButtom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        // String barcodeScanRes = 'https://www.facebook.com/wilian.huanca.marca/';
        String barcodeScanRes = 'geo:-13.975662469546005,-71.56345103693235';
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        // '#363636', 'Cancelar', true, ScanMode.QR);
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        // // print(barcodeScanRes);
        // if (barcodeScanRes != null) {
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        switch (nuevoScan.tipo) {
          case 'geo':
            scanListProvider.cargarScansPorTipo('geo');
            return MapasPage();
          case 'http':
            scanListProvider.cargarScansPorTipo('http');
            return DireccionesPage();
          default:
            return MapasPage();
        }
        //launchURL(context, nuevoScan);
        //   scanListProvider.nuevoScan('geo:15.33,15.66');
        // }
      },
    );
  }
}
