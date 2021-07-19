import 'package:did/global_components/loading_indicator.dart';
import 'package:did/theme.dart';
import 'package:flutter/material.dart';

class LoadingAlert extends StatelessWidget {
  const LoadingAlert({required this.title, required this.message, Key? key})
      : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding, vertical: kSmallPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24, width: 24, child: LoadingIndicator()),
            const SizedBox(
              width: kSmallPadding,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    message,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
