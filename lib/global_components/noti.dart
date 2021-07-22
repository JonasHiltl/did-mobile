import 'package:did/theme.dart';
import "package:flash/flash.dart";
import "package:flutter/material.dart";

void showSuccessNoti({
  required String message,
  required BuildContext context,
}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    builder: (context, controller) {
      return Flash.dialog(
        barrierColor: Colors.transparent,
        controller: controller,
        alignment: Alignment.topCenter,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        backgroundColor: Theme.of(context).backgroundColor,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(3.0, 3.0),
            blurRadius: 6,
          )
        ],
        margin: const EdgeInsets.only(top: kMediumPadding),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding,
            vertical: kSmallPadding,
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            const Icon(
              Icons.check_circle,
              color: Color(0xFF52C41A),
              size: 18.0,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ]),
        ),
      );
    },
  );
}

void showErrorNoti({
  required String message,
  required BuildContext context,
}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    builder: (context, controller) {
      return Flash.dialog(
        barrierColor: Colors.transparent,
        alignment: Alignment.topCenter,
        controller: controller,
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        backgroundColor: Theme.of(context).backgroundColor,
        boxShadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: const Offset(3.0, 3.0),
              blurRadius: 8)
        ],
        margin: const EdgeInsets.only(top: kMediumPadding),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSmallPadding,
            vertical: kSmallPadding,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.cancel,
                color: Color(0xFFFF4D4F),
                size: 18.0,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      );
    },
  );
}
