import 'package:flutter/foundation.dart';
import 'package:canvanime/Preferences/DarkThemePreferences.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference appPreferences = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    appPreferences.setDarkTheme(value);
    notifyListeners();
  }
}