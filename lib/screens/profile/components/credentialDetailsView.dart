import 'package:did/globalComponents/credential.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CredentialDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is Verified) {
        return Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(
                    Icons.admin_panel_settings_rounded,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credential",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      "This credential secures your personal information",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Credential(
              title: "Personal Information Credential",
              spacing: 4,
              children: <Widget>[
                Text(
                  state.did.credential.credentialSubject.firstName,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  state.did.credential.credentialSubject.lastName,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  DateFormat.yMMMd().format(
                      state.did.credential.credentialSubject.dateOfBirth),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  state.did.credential.credentialSubject.sex,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(DateFormat.yMMMd().add_jm().format(
                    DateTime.parse(state.did.credential.issuanceDate)
                        .toLocal())),
              ],
            ),
          ],
        );
      } else {
        return const Text("Unverified");
      }
    });
  }
}
