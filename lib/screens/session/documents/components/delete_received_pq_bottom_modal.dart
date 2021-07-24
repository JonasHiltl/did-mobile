import 'package:did/global_components/material_bottom_sheet.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';

// this bottom modal gets called when an item inside of the received patient questionnaire folder gets long pressed
// or the vertical dots of the item get clicked
// through this bottom Modal the item can be deleted
void receivedPqBottomModal(
  BuildContext context,
  int i,
  Verified sessionState,
) =>
    bottomSheet(
      context: context,
      content: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<SessionCubit>().deleteReceivedPQ(i, sessionState);
            },
            child: Text(
              L.of(context).delete,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).errorColor,
                  ),
            ),
          ),
        ),
      ],
    );
