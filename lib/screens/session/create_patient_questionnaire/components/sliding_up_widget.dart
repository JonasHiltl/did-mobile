import 'package:did/global_components/empty.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_bloc.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_event.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<CreatePQBloc, CreatePQState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
        child: Column(
          children: [
            _buildDragHandle(),
            Expanded(
              child: CustomScrollView(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                slivers: <Widget>[
                  if (state.allergies.isEmpty) ...[
                    SliverToBoxAdapter(
                      child: _buildEmptyState(context, L.of(context).allergies),
                    )
                  ],
                  SliverList(
                      delegate: SliverChildListDelegate([
                    if (state.allergies.isNotEmpty) ...[
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        L.of(context).allergies,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _BuildListHead(
                        titles: [L.of(context).allergy, L.of(context).symptom],
                      ),
                      for (var i = 0; i < state.allergies.length; i++)
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6)),
                            left: BorderSide(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6)),
                            right: BorderSide(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6)),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Text(state.allergies[i].name),
                                )),
                                Expanded(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child:
                                            Text(state.allergies[i].symptoms),
                                      ),
                                      GestureDetector(
                                        onTap: () => context
                                            .read<CreatePQBloc>()
                                            .add(CreatePQRemoveAllergy(
                                                index: i)),
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: Theme.of(context).errorColor,
                                        ),
                                      )
                                    ]))
                              ],
                            ),
                          ),
                        ),
                    ],
                    if (state.medications.isEmpty) ...[
                      _buildEmptyState(context, L.of(context).pluralMedication)
                    ],
                    if (state.medications.isNotEmpty) ...[
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        L.of(context).pluralMedication,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _BuildListHead(
                        titles: [
                          L.of(context).medication,
                          L.of(context).condition,
                          L.of(context).frequency,
                          L.of(context).dose,
                        ],
                      ),
                      for (var i = 0; i < state.medications.length; i++)
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6)),
                            left: BorderSide(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6)),
                            right: BorderSide(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6)),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Text(state.medications[i].name),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Text(state.medications[i].condition),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Text(state.medications[i].frequency),
                                )),
                                Expanded(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: Text(state.medications[i].dose),
                                      ),
                                      GestureDetector(
                                        onTap: () => context
                                            .read<CreatePQBloc>()
                                            .add(CreatePQRemoveMedication(
                                                index: i)),
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: Theme.of(context).errorColor,
                                        ),
                                      )
                                    ]))
                              ],
                            ),
                          ),
                        ),
                    ]
                  ]))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  SizedBox _buildEmptyState(BuildContext context, String text) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Empty(
          text: L.of(context).noAllergiesAdded,
        ),
        Container()
      ]),
    );
  }

  Widget _buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: SizedBox(
          height: 20,
          width: double.infinity,
          child: Center(
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
          ),
        ),
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}

class _BuildListHead extends StatelessWidget {
  final List<String> titles;
  const _BuildListHead({
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            .onSurface
                            .withOpacity(0.60)),
                  )),
                )
                .toList()),
      ),
    );
  }
}
