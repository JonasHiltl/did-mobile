import 'package:flutter/material.dart';

class BottomSheetDraghandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 55,
          height: 4,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }
}
