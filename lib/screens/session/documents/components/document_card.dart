import 'package:flutter/material.dart';

import '../../../../theme.dart';

class HorizontalDocumentCard extends StatelessWidget {
  const HorizontalDocumentCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final String subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: kSmallPadding,
        ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5),
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          padding: const EdgeInsets.all(0.0),
          visualDensity: VisualDensity.compact,
          onPressed: onPressed,
          icon: const Icon(Icons.more_vert),
        )
      ],
    );
  }
}

class VerticalDocumentCard extends StatelessWidget {
  const VerticalDocumentCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final String subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            IconButton(
              padding: const EdgeInsets.all(0.0),
              visualDensity: VisualDensity.compact,
              onPressed: onPressed,
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
