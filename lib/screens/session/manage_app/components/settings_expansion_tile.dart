import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:did/providers/app_settings/app_settings_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:did/providers/app_settings/app_settings_bloc.dart';
import 'package:did/providers/app_settings/app_settings_state.dart';
import 'package:did/screens/session/manage_app/screens/language.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme.dart';

class SettingsExpansionTile extends StatefulWidget {
  const SettingsExpansionTile({Key? key}) : super(key: key);

  @override
  _SettingsExpansionTileState createState() => _SettingsExpansionTileState();
}

class _SettingsExpansionTileState extends State<SettingsExpansionTile> {
  bool isSettingsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          childrenPadding: const EdgeInsets.all(0),
          title: Row(children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.settings,
                color: Theme.of(context).backgroundColor,
                size: 20,
              ),
            ),
            const SizedBox(
              width: kSmallPadding,
            ),
            Text(
              L.of(context).settings,
              style: Theme.of(context).textTheme.headline6,
            ),
          ]),
          trailing: Transform.rotate(
            angle: isSettingsExpanded ? 90 * math.pi / 180 : 0,
            child: Icon(
              Icons.chevron_right,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          onExpansionChanged: (value) => setState(
            () => isSettingsExpanded = value,
          ),
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  curve: Curves.easeInOut,
                  child: const LanguageScreen(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kMediumPadding,
                  vertical: kSmallPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          L.of(context).language,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        BlocBuilder<AppSettingsBloc, AppSettingsState>(
                          builder: (context, state) {
                            return Text(
                              state.language == "en" ? "English" : "Deutsch",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                            );
                          },
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.8),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kMediumPadding,
                vertical: kSmallPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        L.of(context).darkMode,
                      )
                    ],
                  ),
                  BlocBuilder<AppSettingsBloc, AppSettingsState>(
                    builder: (context, state) {
                      return Platform.isIOS
                          ? Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: state.themeData == AppTheme.dark
                                    ? true
                                    : false,
                                onChanged: (value) =>
                                    context.read<AppSettingsBloc>().add(
                                          ThemeChanged(
                                            theme:
                                                state.themeData == AppTheme.dark
                                                    ? AppTheme.light
                                                    : AppTheme.dark,
                                          ),
                                        ),
                              ),
                            )
                          : SizedBox(
                              height: 15,
                              child: Switch(
                                activeColor: Theme.of(context).primaryColor,
                                value: state.themeData == AppTheme.dark
                                    ? true
                                    : false,
                                onChanged: (value) =>
                                    context.read<AppSettingsBloc>().add(
                                          ThemeChanged(
                                            theme:
                                                state.themeData == AppTheme.dark
                                                    ? AppTheme.light
                                                    : AppTheme.dark,
                                          ),
                                        ),
                              ),
                            );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
