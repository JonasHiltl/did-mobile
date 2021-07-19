import 'package:did/theme.dart';
import 'package:flutter/material.dart';

class DocumentFolderPreview extends StatelessWidget {
  final Color backgroundColor;
  final Icon icon;
  final String title;
  final String subtitle;
  final Function()? onTap;
  const DocumentFolderPreview({
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.7),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(kSmallPadding),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(6)),
              child: icon,
            ),
            const SizedBox(
              width: kSmallPadding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
