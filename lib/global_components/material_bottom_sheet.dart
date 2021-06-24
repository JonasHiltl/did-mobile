import 'package:flutter/material.dart';

Future bottomSheet({
  required BuildContext context,
  required List<Widget> content,
  String? title,
}) {
  return showModalBottomSheet(
    useRootNavigator: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    backgroundColor: Theme.of(context).backgroundColor,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  if (title != null)
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                    )
                ],
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                ),
              )
            ],
          ),
          ...content,
        ],
      ),
    ),
  );
}
