import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:did/providers/app_settings/app_settings_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:did/providers/app_settings/app_settings_bloc.dart';
import 'package:did/providers/app_settings/app_settings_state.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme.dart';

class SecurityExpansionTile extends StatefulWidget {
  const SecurityExpansionTile({Key? key}) : super(key: key);

  @override
  _SecurityExpansionTileState createState() => _SecurityExpansionTileState();
}

class _SecurityExpansionTileState extends State<SecurityExpansionTile> {
  bool isSecurityExpanded = false;

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
                color: Colors.orange,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.shield,
                color: Theme.of(context).backgroundColor,
                size: 20,
              ),
            ),
            const SizedBox(
              width: kSmallPadding,
            ),
            Text(
              L.of(context).security,
              style: Theme.of(context).textTheme.headline6,
            ),
          ]),
          trailing: Transform.rotate(
            angle: isSecurityExpanded ? 90 * math.pi / 180 : 0,
            child: Icon(
              Icons.chevron_right,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          onExpansionChanged: (value) => setState(
            () => isSecurityExpanded = value,
          ),
          children: [
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
                        Platform.isIOS
                            ? L.of(context).touchId
                            : L.of(context).fingerprint,
                      )
                    ],
                  ),
                  BlocBuilder<AppSettingsBloc, AppSettingsState>(
                    builder: (context, state) {
                      return Platform.isIOS
                          ? Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: state.useTouchID,
                                onChanged: (value) => showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text(
                                        state.useTouchID
                                            ? L.of(context).disableTouchID
                                            : L.of(context).activateTouchID,
                                      ),
                                      content: Text(
                                        state.useTouchID
                                            ? L.of(context).disableTouchIDText
                                            : L.of(context).touchIDText,
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(L.of(context).no),
                                        ),
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            context.read<AppSettingsBloc>().add(
                                                  TouchIDChanged(
                                                    useTouchID:
                                                        !state.useTouchID,
                                                  ),
                                                );
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            L.of(context).yes,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 15,
                              child: Switch(
                                activeColor: Theme.of(context).primaryColor,
                                value: state.useTouchID,
                                onChanged: (value) => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        state.useTouchID
                                            ? L.of(context).disableFingerprint
                                            : L.of(context).activateFingerprint,
                                      ),
                                      content: Text(
                                        state.useTouchID
                                            ? L
                                                .of(context)
                                                .disableFingerprintText
                                            : L.of(context).fingerprintText,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            L.of(context).no,
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<AppSettingsBloc>().add(
                                                  TouchIDChanged(
                                                    useTouchID:
                                                        !state.useTouchID,
                                                  ),
                                                );
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            L.of(context).yes,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
