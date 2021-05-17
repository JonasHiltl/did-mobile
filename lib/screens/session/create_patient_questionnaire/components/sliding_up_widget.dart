import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpWidget extends StatefulWidget {
  final Widget body;
  const SlidingUpWidget({required this.body});
  @override
  _SlidingUpWidgetState createState() => _SlidingUpWidgetState();
}

class _SlidingUpWidgetState extends State<SlidingUpWidget> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        boxShadow: [
          BoxShadow(
              color: (Colors.grey[400])!,
              offset: const Offset(0, 8),
              blurRadius: 20,
              spreadRadius: 1.0)
        ],
        controller: panelController,
        minHeight: MediaQuery.of(context).size.height * 0.1,
        maxHeight: MediaQuery.of(context).size.height * 0.75,
        panelBuilder: (controller) => PanelWidget(
              controller: controller,
              panelController: panelController,
            ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        body: widget.body);
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      children: [
        buildDragHandle(),
        const SizedBox(
          height: 2,
        ),
        const Text(
            "nulla facilisi etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus in ornare quam viverra orci sagittis eu volutpat odio facilisis mauris sit amet massa vitae tortor condimentum lacinia quis vel eros donec ac odio tempor orci dapibus ultrices in iaculis nunc sed augue lacus viverra vitae congue eu"),
        const SizedBox(
          height: 14,
        ),
        const Text(
            "eleifend quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra justo nec ultrices dui sapien eget mi"),
      ],
    );
  }

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
        ),
      );
  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
