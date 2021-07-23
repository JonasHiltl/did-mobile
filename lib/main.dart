import 'package:device_preview/device_preview.dart';
import 'package:device_preview/plugins.dart';
import 'package:did/providers/app_screen_state/app_navigator.dart';
import 'package:did/providers/app_screen_state/auth_flow/auth_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/retrieve_document/repo/retrieve_document_repo.dart';
import 'package:did/providers/retrieve_document/retrieve_document_bloc.dart';
import "package:did/screens/auth/introduction/introduction.dart";
import 'package:did/theme.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/services.dart";

import 'data/common_backend_repo.dart';
import "generated/l10n.dart";
import 'providers/app_settings/app_settings_bloc.dart';
import 'providers/app_settings/app_settings_state.dart';
import 'providers/app_settings/app_settings_storage.dart';
import 'providers/create_did/create_did_bloc.dart';
import 'providers/create_did/repo/create_did_repository.dart';
import "screens/auth/creation/creation.dart";

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferencesInit();
  runApp(
    /* DevicePreview(
      plugins: const [FileExplorerPlugin(), ScreenshotPlugin()],
      builder: (context) =>  */MyApp(),
      /* enabled: !kReleaseMode,
    ), */
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CreateDidRepository()),
        RepositoryProvider(create: (context) => CommonBackendRepo()),
        RepositoryProvider(create: (context) => RetrieveDocumentRepo())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingsBloc>(
            create: (context) => AppSettingsBloc(
              language: getLanguage(),
              theme: getTheme(),
              useTouchID: getUseTouchID(),
            ),
          ),
          // the session cubit needs to be above the AuthCubit because the AuthCubit depends on sessionCubit
          BlocProvider<SessionCubit>(
            create: (context) => SessionCubit(
              CommonBackendRepo(),
              appSettingsBloc: context.read<AppSettingsBloc>(),
            ),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              context.read<SessionCubit>(),
            ),
          ),
          BlocProvider<CreateDidBloc>(
            create: (context) => CreateDidBloc(
              repo: context.read<CreateDidRepository>(),
              authCubit: context.read<AuthCubit>(),
            ),
          ),
        ],
        child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, state) {
            return MaterialApp(
              title: "Flutter Demo",
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              theme: appTheme[state.themeData],
              localizationsDelegates: const [
                L.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: L.delegate.supportedLocales,
              locale: Locale(state.language),
              home: AppNavigator(),
              routes: {
                "/introduction": (context) => const Introduction(),
                "/create": (context) => Creation(),
              },
            );
          },
        ),
      ),
    );
  }
}
