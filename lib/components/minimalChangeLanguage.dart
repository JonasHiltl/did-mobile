import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../blocs/language/languageBloc.dart";
import '../blocs/language/languageEvent.dart';
import "../blocs/language/languageState.dart";

class MinimalChangeLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
        return PopupMenuButton(
          offset: const Offset(0, 20),
          elevation: 2,
          iconSize: 18,
          onSelected: (value) {
            context.read<LanguageBloc>().add(
                  LanguageChanged(language: value.toString()),
                );
          },
          icon: const Icon(
            Icons.language,
            size: 20,
          ),
          tooltip: "Change language",
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
                value: "en",
                child: Row(children: [
                  Text("English", style: Theme.of(context).textTheme.bodyText2),
                  if (state.language == "en") ...[
                    const SizedBox(width: 15),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.black.withOpacity(0.60),
                    )
                  ]
                ])),
            PopupMenuItem(
                value: "de",
                child: Row(children: [
                  Text("Deutsch", style: Theme.of(context).textTheme.bodyText2),
                  if (state.language == "de") ...[
                    const SizedBox(width: 15),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.black.withOpacity(0.60),
                    )
                  ]
                ])),
          ],
        );
      })
    ]);
  }
}
