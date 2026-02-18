import 'package:flutter/foundation.dart';

class UiProvider extends ChangeNotifier{
  int _selectedMenuOption = 1;

  int get selectedMenuOption{
    return this._selectedMenuOption;
  }

  set selectedMenuOption(int index){
    this._selectedMenuOption=index;
    notifyListeners();
  }
}