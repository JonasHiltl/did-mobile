import 'package:did/theme.dart';
import 'package:flutter/material.dart';

class ChangeSingleValueWithExpandIcon extends StatelessWidget {
  final Function() onTap;
  final String label;
  final String value;
  const ChangeSingleValueWithExpandIcon(
      {required this.onTap, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(kSmallPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
            ),
            Row(
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                ),
                const SizedBox(
                  width: kSmallPadding,
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
