import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/src/providers/scanlist_provider.dart';
import 'package:qrreaderapp/src/providers/ui_provider.dart';
import 'package:qrreaderapp/src/widgets/customnavigatorbar_widget.dart';
import 'package:qrreaderapp/src/models/qrscan_model.dart';

import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/widgets/scanbuttom_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () async {},
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScanButtom(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener current index de UIProvider
    final uiProvider = Provider.of<UIProvider>(context);
    //cambiar para mostrar la pagina que me interesa
    int currentIndex = uiProvider.selectedMenuOpcion;

    //Usar ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
