import 'package:did/global_components/credential.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';
import '../theme.dart';

class AccessCredential extends StatelessWidget {
  const AccessCredential({
    Key? key,
    required this.sharerID,
    required this.expiration,
  }) : super(key: key);

  final String sharerID;
  final String? expiration;

  @override
  Widget build(BuildContext context) {
    return Credential(
      title: L.of(context).accessVC,
      highlightColor: Colors.teal.shade400,
      children: [
        Padding(
          padding: const EdgeInsets.all(kSmallPadding),
          child: Row(
            children: [
              Text(
                L.of(context).sharer,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                width: kSmallPadding,
              ),
              Expanded(
                child: Text(
                  sharerID,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (expiration == null)
          Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open,
                  color: Colors.teal.shade400,
                ),
                const SizedBox(
                  width: kSmallPadding,
                ),
                Text(
                  L.of(context).unrestrictedAccess,
                ),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open,
                  color: Colors.teal.shade400,
                ),
                const SizedBox(
                  width: kSmallPadding,
                ),
                Text(
                  L.of(context).expiresAt,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  width: kSmallPadding,
                ),
                Text(
                  DateFormat.yMMMd().add_jm().format(
                        DateTime.parse(expiration!).toLocal(),
                      ),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
