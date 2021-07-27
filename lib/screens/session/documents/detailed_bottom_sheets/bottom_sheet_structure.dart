import 'package:did/global_components/bottom_Sheet_drag_handle.dart';
import 'package:flutter/material.dart';

import '../../../../theme.dart';

class BottomSheetStructure extends StatelessWidget {
  const BottomSheetStructure({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: SingleChildScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(
                kSmallPadding,
                4,
                kSmallPadding,
                kSmallPadding,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: BottomSheetDraghandle(),
                  ),
                  ...children
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeDismissible({
    required Widget child,
    required BuildContext context,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
