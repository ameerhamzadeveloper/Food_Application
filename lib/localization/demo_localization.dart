import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization{
 final Locale locale;
 DemoLocalization(this.locale);

  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String ,String> _localizedValue;

  Future load() async {
    String jsonStringValue =
        await rootBundle.loadString('lib/languages/${locale.languageCode}.json');

    Map<String , dynamic> mappedJson = json.decode(jsonStringValue);

    _localizedValue = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key){
    return _localizedValue[key];
  }

  static LocalizationsDelegate<DemoLocalization> delegate = _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate extends LocalizationsDelegate<DemoLocalization>{
  const _DemoLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;
  
}