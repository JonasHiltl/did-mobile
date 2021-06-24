import 'package:flutter/material.dart';

Future bottomSheet(
    {required BuildContext context, required List<Widget> buttons}) {
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                ),
              )
            ],
          ),
          ...buttons,
        ],
      ),
    ),
  );
}
