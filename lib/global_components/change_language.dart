import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import '../providers/language/language_bloc.dart';
import '../providers/language/language_event.dart';
import '../providers/language/language_state.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      return SizedBox(
        height: isExpanded ? 130 : 60,
        child: Stack(clipBehavior: Clip.none, children: [
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
            ),
          ),
          if (isExpanded)
            Positioned(
              left: 20,
              bottom: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                          color: const Color(0xFFACB6C5).withOpacity(0.3))),
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => context.read<LanguageBloc>().add(
                              LanguageChanged(language: "de"),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 8.0),
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
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => context.read<LanguageBloc>().add(
                              LanguageChanged(language: "en"),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 8.0),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )
        ]),
      );
    });
  }
}
