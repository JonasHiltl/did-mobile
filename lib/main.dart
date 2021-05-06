import "package:did/screens/introduction/introduction.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/services.dart";

import 'blocs/createDid/createDidBloc.dart';
import "blocs/language/languageBloc.dart";
import "blocs/language/languageState.dart";
import "blocs/language/storageUtils.dart";
import 'data/createDidRepository.dart';
import "generated/l10n.dart";
import 'screens/creation/creation.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguagePreference.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

const ColorScheme colorScheme = ColorScheme.light(
    primary: Color(0xFF3861FB),
    secondary: Color(0xFF1890FF),
    primaryVariant: Color(0xFF0B0C10),
    secondaryVariant: Color(0xFF0B0C10),
    onSecondary: Color(0xFFFFFFFF),
    onError: Color(0xFFFF4D4F));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => CreateDidRepository(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<LanguageBloc>(
                  create: (context) =>
                      LanguageBloc(LanguagePreference.getLanguage())),
              BlocProvider<CreateDidBloc>(
                  create: (context) =>
                      CreateDidBloc(repo: context.read<CreateDidRepository>()))
            ],
            child: BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return MaterialApp(
                  title: "Flutter Demo",
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      colorScheme: colorScheme,
                      primaryColor: colorScheme.primary,
                      accentColor: colorScheme.secondary,
                      backgroundColor: colorScheme.background,
                      textTheme: TextTheme(
                        bodyText1: TextStyle(
                            color: Colors.black.withOpacity(0.85),
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                        bodyText2: TextStyle(
                            color: Colors.black.withOpacity(0.85),
                            fontSize: 14),
                      ),
                      elevatedButtonTheme: ElevatedButtonThemeData(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                const interactiveStates = <MaterialState>{
                                  MaterialState.focused,
                                  MaterialState.hovered,
                                  MaterialState.pressed
                                };
                                if (states.any(interactiveStates.contains)) {
                                  return Colors.white;
                                }
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.black.withOpacity(0.25);
                                }
                                return Colors.white;
                              }),
                              elevation: MaterialStateProperty.all(0.0),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(20, 12, 20, 12)),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFF40A9FF);
                                }
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color(0xFF40A9FF);
                                }
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color(0xFF2C54E9);
                                }
                                if (states.contains(MaterialState.disabled)) {
                                  return const Color(0xFFF5F5F5);
                                }
                                return colorScheme.primary;
                              }),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFF40A9FF);
                                }
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color(0xFF40A9FF);
                                }
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color(0xFF2C54E9);
                                }
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.black.withOpacity(0.03);
                                }
                                return colorScheme.primary;
                              }),
                              shape: MaterialStateProperty.resolveWith<
                                      RoundedRectangleBorder>(
                                  (Set<MaterialState> states) {
                                const interactiveStates = <MaterialState>{
                                  MaterialState.focused,
                                  MaterialState.hovered,
                                  MaterialState.pressed
                                };
                                if (states.any(interactiveStates.contains)) {
                                  return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(
                                          color: colorScheme.primary));
                                }
                                if (states.contains(MaterialState.disabled)) {
                                  return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: const BorderSide(
                                          color: Color(0xFFD9D9D9)));
                                }
                                return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side:
                                        BorderSide(color: colorScheme.primary));
                              }))),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                          style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          const interactiveStates = <MaterialState>{
                            MaterialState.focused,
                            MaterialState.hovered,
                            MaterialState.pressed
                          };
                          if (states.any(interactiveStates.contains)) {
                            return colorScheme.primary;
                          }
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.black.withOpacity(0.25);
                          }
                          return Colors.black.withOpacity(0.85);
                        }),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          const interactiveStates = <MaterialState>{
                            MaterialState.focused,
                            MaterialState.hovered,
                            MaterialState.pressed,
                            MaterialState.disabled
                          };
                          if (states.any(interactiveStates.contains)) {
                            return Colors.transparent;
                          }
                          return colorScheme.primary;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0))),
                        side: MaterialStateProperty.resolveWith<BorderSide>(
                            (Set<MaterialState> states) {
                          const interactiveStates = <MaterialState>{
                            MaterialState.focused,
                            MaterialState.hovered,
                            MaterialState.pressed
                          };
                          if (states.any(interactiveStates.contains)) {
                            return BorderSide(color: colorScheme.primary);
                          }
                          if (states.contains(MaterialState.disabled)) {
                            return const BorderSide(color: Color(0xFFD9D9D9));
                          }
                          return const BorderSide(color: Color(0xFFACB6C5));
                        }),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(20, 12, 20, 12)),
                      )),
                      textButtonTheme: TextButtonThemeData(
                          style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(20, 12, 20, 12)),
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          const interactiveStates = <MaterialState>{
                            MaterialState.focused,
                            MaterialState.hovered,
                            MaterialState.pressed
                          };
                          if (states.any(interactiveStates.contains)) {
                            return colorScheme.primary;
                          }
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.black.withOpacity(0.25);
                          }
                          return Colors.black.withOpacity(0.85);
                        }),
                      ))),
                  localizationsDelegates: const [
                    L.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: L.delegate.supportedLocales,
                  locale: Locale(state.language),
                  initialRoute: "/introduction",
                  routes: {
                    "/introduction": (context) => Introduction(),
                    "/create": (context) => Creation(),
                  },
                );
              },
            )));
  }
}
