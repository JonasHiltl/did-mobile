import 'package:did/global_components/empty.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../generated/l10n.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          buildDragHandle(),
          const SizedBox(
            height: 2,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                L.of(context).allergies,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              Empty(text: L.of(context).noAllergiesAdded),
              Container()
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                L.of(context).pluralMedication,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              Empty(text: L.of(context).noMedicationAdded),
              Container()
            ],
          )),
        ],
      ),
    );
  }

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 50,
              height: 5,
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
