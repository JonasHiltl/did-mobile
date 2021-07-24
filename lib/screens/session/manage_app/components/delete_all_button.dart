import 'dart:io' show Platform;

import 'package:did/generated/l10n.dart';
import 'package:did/providers/app_screen_state/session_flow/session_bloc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAllButton extends StatelessWidget {
  const DeleteAllButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Platform.isAndroid
          ? showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(L.of(context).deleteData),
                  content: Text(L.of(context).confirmDataDeletion),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        L.of(context).no,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<SessionBloc>().add(DeleteAll());
                        Navigator.pop(context);
                      },
                      child: Text(
                        L.of(context).yes,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  ],
                );
              },
            )
          : showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text(L.of(context).deleteData),
                  content: Text(L.of(context).confirmDataDeletion),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: Text(L.of(context).no),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        context.read<SessionBloc>().add(
                              DeleteAll(),
                            );
                        Navigator.pop(context);
                      },
                      child: Text(
                        L.of(context).yes,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  ],
                );
              },
            ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const Color(0xFFf84042);
          }
          if (states.contains(MaterialState.hovered)) {
            return const Color(0xFFf84042);
          }
          if (states.contains(MaterialState.pressed)) {
            return const Color(0xFFe40a0c);
          }
          if (states.contains(MaterialState.disabled)) {
            return const Color(0xFFF5F5F5);
          }
          return Theme.of(context).errorColor;
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const Color(0xFFf84042);
          }
          if (states.contains(MaterialState.hovered)) {
            return const Color(0xFFf84042);
          }
          if (states.contains(MaterialState.pressed)) {
            return const Color(0xFFe40a0c);
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.black.withOpacity(0.03);
          }
          return Theme.of(context).errorColor;
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: Theme.of(context).errorColor),
          ),
        ),
      ),
      child: Text(
        L.of(context).deleteAll,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
