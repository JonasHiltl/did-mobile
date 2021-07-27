import 'package:flutter/material.dart';

import '../theme.dart';

class BuildRow extends StatelessWidget {
  const BuildRow({
    Key? key,
    required this.label1,
    required this.text1,
    required this.label2,
    required this.text2,
  }) : super(key: key);

  final String label1;
  final String text1;
  final String label2;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  label1,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Text(
                  text1,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  label2,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Text(
                  text2,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
