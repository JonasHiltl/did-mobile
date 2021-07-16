import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import '../generated/l10n.dart';
import '../providers/app_settings/app_settings_bloc.dart';
import '../providers/app_settings/app_settings_event.dart';
import '../providers/app_settings/app_settings_state.dart';

class MinimalChangeLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      BlocBuilder<AppSettingsBloc, AppSettingsState>(builder: (context, state) {
        return PopupMenuButton(
          offset: const Offset(0, 40),
          elevation: 2,
          iconSize: 20,
          onSelected: (value) {
            context.read<AppSettingsBloc>().add(
                  LanguageChanged(language: value.toString()),
                );
          },
          icon: const Icon(Icons.language),
          tooltip: L.of(context).changeLanguage,
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
                value: "en",
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("English",
                          style: Theme.of(context).textTheme.bodyText2),
                      if (state.language == "en") ...[
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Colors.black.withOpacity(0.60),
                        )
                      ]
                    ])),
            PopupMenuItem(
              value: "de",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Deutsch", style: Theme.of(context).textTheme.bodyText2),
                  if (state.language == "de") ...[
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.black.withOpacity(0.60),
                    )
                  ]
                ],
              ),
            ),
          ],
        );
      })
    ]);
  }
}
