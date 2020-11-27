import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  int get selectedMenuOpcion {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpcion(int opcion) {
    this._selectedMenuOpt = opcion;
    notifyListeners();
  }
}
