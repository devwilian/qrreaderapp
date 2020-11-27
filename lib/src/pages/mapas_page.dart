import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/providers/scanlist_provider.dart';
import 'package:qrreaderapp/src/widgets/historialscan_widget.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HistorialScans(tipo: 'geo');
  }
}
