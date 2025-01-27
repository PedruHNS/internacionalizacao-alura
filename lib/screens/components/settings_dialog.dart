import 'package:flutter/material.dart';
import 'package:flutter_i18n/controller/localization_manager.dart';
import 'package:flutter_i18n/main.dart';
import 'package:flutter_i18n/screens/components/show_loading_dialog.dart';
import 'package:provider/provider.dart';

import '../../dao/book_database.dart';
import '../../theme.dart';
import 'primary_button.dart';

Future<void> showSettingsDialog({
  required BuildContext context,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: ModalDecorationProperties.modalBorder,
        child: const _SettingsDialog(),
      );
    },
  );
}

class _SettingsDialog extends StatefulWidget {
  const _SettingsDialog();

  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<_SettingsDialog> {
  DisplayedLanguages _language = DisplayedLanguages.device;

  @override
  void initState() {
    String languageCode = context.read<LocalizationManager>().languageCode;
    _language = getDisplayedLanguagesByLanguageCode(languageCode);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.watch<LocalizationManager>().languageDialogText,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<DisplayedLanguages>(
            value: _language,
            items: [
              DropdownMenuItem(
                value: DisplayedLanguages.device,
                child: Row(
                  children: [
                    const Icon(Icons.devices, size: 24),
                    const SizedBox(width: 8),
                    Text(context
                        .watch<LocalizationManager>()
                        .deviceDefaultDropDownText),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: DisplayedLanguages.portuguese,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/flags/portuguese.png",
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(context
                        .watch<LocalizationManager>()
                        .portugueseDropdownText),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: DisplayedLanguages.english,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/flags/english.png",
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(context
                        .watch<LocalizationManager>()
                        .englishDropdownText),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: DisplayedLanguages.spanish,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/flags/spanish.png",
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(context
                        .watch<LocalizationManager>()
                        .spanishDropdownText),
                  ],
                ),
              ),
            ],
            onChanged: (DisplayedLanguages? newLanguage) {
              if (newLanguage != null) {
                onChangedLanguage(newLanguage);
              }
            },
          ),
          Text(
            context.watch<LocalizationManager>().clearBooksText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          PrimaryButton(
            text: context.watch<LocalizationManager>().clearDialogButtonText,
            onTap: () {
              wipeBooks();
            },
          ),
        ],
      ),
    );
  }

  void wipeBooks() async {
    await PersonalBookDatabase().deleteAll();
    closeDialog();
  }

  void closeDialog() {
    Navigator.pop(context);
  }

  void onChangedLanguage(DisplayedLanguages language) async {
    String newCode = "en";

    switch (language) {
      case DisplayedLanguages.device:
        newCode = Localizations.localeOf(context).languageCode;
        break;
      case DisplayedLanguages.portuguese:
        newCode = "pt";
        break;

      case DisplayedLanguages.english:
        newCode = "en";
        break;

      case DisplayedLanguages.spanish:
        newCode = "es";
        break;
    }

    showLoadingDialog(
      context,
      context.read<LocalizationManager>().setLanguage(newCode),
    );
  }
}

enum DisplayedLanguages { device, portuguese, english, spanish }

DisplayedLanguages getDisplayedLanguagesByLanguageCode(String languageCode) {
  return switch (languageCode) {
    'pt' => DisplayedLanguages.portuguese,
    'en' => DisplayedLanguages.english,
    'es' => DisplayedLanguages.spanish,
    _ => DisplayedLanguages.device
  };
}
