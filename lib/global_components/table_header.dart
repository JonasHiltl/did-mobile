import 'package:did/theme.dart';
import 'package:flutter/material.dart';

class BuildListHead extends StatelessWidget {
  final List<String> titles;
  const BuildListHead({
    required this.titles,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          border: Border.all(
            color: const Color(0xFFACB6C5).withOpacity(0.6),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding, vertical: kSmallPadding),
        child: Row(
          children: titles
              .map(
                (title) => Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6),
                        ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
