import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:did/generated/l10n.dart';

class IdCard extends StatelessWidget {
  const IdCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final credential =
        context.watch<SessionState>().personalDataVc!.credentialSubject;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: RadialGradient(
            colors: [
              const Color(0xFF70dfff),
              Theme.of(context).primaryColor,
            ],
            center: Alignment.topRight,
            radius: 2.2,
          )
          /* LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            //Color(0xFF9fb1f5),
            Color(0xFF48cae4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), */
          ),
      child: Padding(
        padding: const EdgeInsets.all(kSmallPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${credential.firstName} ${credential.lastName}",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                  VerticalDivider(
                    color: Colors.white.withOpacity(0.6),
                    thickness: 2,
                    indent: 3,
                    endIndent: 3,
                  ),
                  Text(
                    "LOGO",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kSmallPadding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  L.of(context).address,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${credential.address.street}, ${credential.address.postalCode} ${credential.address.state}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: kSmallPadding,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      L.of(context).dateOfBirth,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMd().format(
                        credential.dateOfBirth.toLocal(),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      L.of(context).created,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('MM/yy').format(
                        DateTime.parse(
                          context
                              .watch<SessionState>()
                              .personalDataVc!
                              .issuanceDate,
                        ).toLocal(),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
