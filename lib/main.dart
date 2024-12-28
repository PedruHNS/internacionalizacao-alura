import 'package:flutter/material.dart';
import 'package:flutter_i18n/controller/localization_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localization = LocalizationManager();

  await localization.loadLanguageCode();
  await localization.loadLanguageFile(localization.languageCode);
  runApp(ChangeNotifierProvider(
    create: (_) => localization,
    child: const Grimorio(),
  ));
}

class Grimorio extends StatelessWidget {
  const Grimorio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meu Pequeno Grimório",
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt', "BR"),
      ],
      home: const SplashScreen(),
    );
  }
}
