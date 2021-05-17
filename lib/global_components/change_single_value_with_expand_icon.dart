import 'package:flutter/material.dart';

class ChangeSingleValueWithExpandIcon extends StatelessWidget {
  final Function() onTap;
  final String label;
  final String value;
  const ChangeSingleValueWithExpandIcon(
      {required this.onTap, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black.withOpacity(0.6)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.black,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
