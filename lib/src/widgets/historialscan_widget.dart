import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/src/common/util.dart';
import 'package:qrreaderapp/src/providers/scanlist_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HistorialScans extends StatelessWidget {
  final String tipo;

  const HistorialScans({Key key, @required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.listaScans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (context, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarPorId(scans[i].id);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.home_outlined : Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].valor),
          subtitle: Text('ID: ${scans[i].id}'),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[i]),
        ),
      ),
    );
  }
}
