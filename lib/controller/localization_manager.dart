import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/util/prefs_keys.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationManager extends ChangeNotifier {
  String languageCode = 'en';

  final Map<String, Map<String, String>> _mapLanguages = {};

  Future<void> _saveLanguageFile(String newCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      PrefsKeys().languageFile(newCode),
      json.encode(_mapLanguages[newCode]),
    );
  }

  Future<void> loadLanguageFile(String newCode) async {
    if (_mapLanguages[newCode] == null) {
      final prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(PrefsKeys().languageFile(newCode));
      if (result != null) {
        Map<String, dynamic> resultMap = json.decode(result);
        _mapLanguages[newCode] = resultMap.map(
          (key, value) {
            return MapEntry(key, value.toString());
          },
        );
      } else {
        await getLanguageFromServer(newCode);
      }
    }
  }

  String _getSentence(String keySentence) {
    String? sentence = _mapLanguages[languageCode]?[keySentence];
    sentence ??= _mapLanguages["en"]?[keySentence];
    return sentence!;
  }

  Future<void> setLanguage(String newCode) async {
    await loadLanguageFile(newCode);
    await _saveLanguageCode(newCode);
    languageCode = newCode;
    notifyListeners();
  }

  Future<void> _saveLanguageCode(String newCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefsKeys.language, newCode);
  }

  Future<void> loadLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();

    String? possibleLanguage = prefs.getString(PrefsKeys.language);

    if (possibleLanguage != null) {
      languageCode = possibleLanguage;
    } else {
      languageCode = 'en';
    }
    notifyListeners();
  }

  Future<void> getLanguageFromServer(String newCode) async {
    
    String url =
        "https://gist.githubusercontent.com/PedruHNS/e726aa31c060c4c3f75e679f316b741c/raw/bed2925cd6cd9bc7ba18b1a5cf88c89085b0c7a7/app_$newCode.json";

    final response = await http.get(Uri.parse(url));

    Map<String, dynamic> mapResponse = json.decode(response.body);

    _mapLanguages[newCode] = mapResponse.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );

    _saveLanguageFile(newCode);
  }

  String get clearBooksText => _getSentence("clearBooksText");
  String get languageDialogText => _getSentence("languageText");
  String get clearDialogButtonText => _getSentence("clearButton");
  String get portugueseDropdownText => _getSentence("portugueseDropdownText");
  String get englishDropdownText => _getSentence("englishDropdownText");
  String get spanishDropdownText => _getSentence("spanishDropdownText");
  String get homeTitleText => _getSentence("homeTitle");
  String get homeEmptyText => _getSentence("homeEmpty");
  String get homeEmptyCallText => _getSentence("homeEmptyCall");

  String get deviceDefaultDropDownText =>
      _getSentence("defaultDeviceLanguageItem");
}
