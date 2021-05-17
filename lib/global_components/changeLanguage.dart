import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import '../providers/language/languageBloc.dart';
import '../providers/language/languageEvent.dart';
import '../providers/language/languageState.dart';

class ChangeLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      return PopupMenuButton(
          offset: const Offset(0, 36),
          elevation: 2,
          iconSize: 18,
          onSelected: (value) => context.read<LanguageBloc>().add(
                LanguageChanged(language: value.toString()),
              ),
          tooltip: "Change language",
          itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    value: "en",
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("English",
                                style: Theme.of(context).textTheme.bodyText2),
                            if (state.language == "en")
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              )
                          ]),
                    )),
                PopupMenuItem(
                    value: "de",
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Deutsch",
                                style: Theme.of(context).textTheme.bodyText2),
                            if (state.language == "de")
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              )
                          ]),
                    )),
              ],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Icon(
                        Icons.g_translate_rounded,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    if (state.language == "en")
                      const Text("English")
                    else
                      const Text("Deutsch"),
                  ],
                ),
                Icon(
                  Icons.expand_more,
                  color: Colors.black.withOpacity(0.60),
                  size: 20,
                ),
              ],
            ),
          ));
    });
  }
}
