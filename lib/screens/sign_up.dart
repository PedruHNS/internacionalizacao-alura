import 'package:flutter/material.dart';
import '../screens/components/display_text.dart';
import '../screens/components/primary_button.dart';
import '../theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: AppBackgroundProperties.boxDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: DisplayText(AppLocalizations.of(context)!.textSignUp),
                ),
                SizedBox(
                  width: 246,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: TextFormField(
                            style: InputDecorationProperties.textDecoration,
                            decoration:
                                InputDecorationProperties.newInputDecoration(
                              AppLocalizations.of(context)!.sugestionName,
                              AppLocalizations.of(context)!.inputName,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: TextFormField(
                            style: InputDecorationProperties.textDecoration,
                            decoration:
                                InputDecorationProperties.newInputDecoration(
                              AppLocalizations.of(context)!.sugestionEmail,
                              "E-mail",
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            style: InputDecorationProperties.textDecoration,
                            decoration:
                                InputDecorationProperties.newInputDecoration(
                                    "******",
                                    AppLocalizations.of(context)!
                                        .inputPassword),
                            obscureText: true,
                          ),
                        ),
                        PrimaryButton(
                          text: AppLocalizations.of(context)!.buttonRegister,
                          onTap: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: const Size.fromWidth(246),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.buttonSignIn,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
