import 'package:flutter/material.dart';

import '../../../../theme.dart';

class CustomStepper extends StatefulWidget {
  final int currentStep;
  const CustomStepper({required this.currentStep});

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          alignment: Alignment.center,
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor.withOpacity(.2),
          ),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                "1",
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          width: 1.0,
          height: 1.0,
          color: widget.currentStep >= 1
              ? Theme.of(context).primaryColor
              : Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade400
                  : kDarkAccentBG,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          alignment: Alignment.center,
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.currentStep >= 1
                ? Theme.of(context).primaryColor.withOpacity(.2)
                : null,
            border: widget.currentStep >= 1
                ? null
                : Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade400
                        : kDarkAccentBG,
                  ),
          ),
          child: Container(
            width: 30,
            height: 30,
            decoration: widget.currentStep >= 1
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
            child: Center(
              child: Text(
                "2",
                style: TextStyle(
                  color: widget.currentStep >= 1
                      ? Theme.of(context).backgroundColor
                      : Theme.of(context).brightness == Brightness.light
                          ? Colors.black38
                          : kDarkAccentBG,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          width: 1.0,
          height: 1.0,
          color: widget.currentStep >= 2
              ? Theme.of(context).primaryColor
              : Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade400
                  : kDarkAccentBG,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          alignment: Alignment.center,
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.currentStep >= 2
                ? Theme.of(context).primaryColor.withOpacity(.2)
                : null,
            border: widget.currentStep >= 2
                ? null
                : Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade400
                        : kDarkAccentBG,
                  ),
          ),
          child: Container(
            width: 30,
            height: 30,
            decoration: widget.currentStep >= 2
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
            child: Center(
              child: Text(
                "3",
                style: TextStyle(
                  color: widget.currentStep >= 2
                      ? Theme.of(context).backgroundColor
                      : Theme.of(context).brightness == Brightness.light
                          ? Colors.black38
                          : kDarkAccentBG,
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
