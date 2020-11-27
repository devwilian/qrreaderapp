import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/src/providers/scanlist_provider.dart';
import 'package:qrreaderapp/src/widgets/historialscan_widget.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HistorialScans(tipo: 'http');
  }
}
