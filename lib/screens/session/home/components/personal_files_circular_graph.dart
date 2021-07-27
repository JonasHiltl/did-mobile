import 'package:did/models/file_type_data/file_type_data.dart';
import 'package:did/providers/app_screen_state/session_flow/session_bloc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';

class PersonalFilesCircularGraph extends StatefulWidget {
  const PersonalFilesCircularGraph();

  @override
  _PersonalFilesCircularGraphState createState() =>
      _PersonalFilesCircularGraphState();
}

class _PersonalFilesCircularGraphState
    extends State<PersonalFilesCircularGraph> {
  late List<FileTypeData> data;

  List<PieChartSectionData> getSections() => data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          showTitle: false,
          radius: 3,
        );

        return MapEntry(index, value);
      })
      .values
      .toList();

  @override
  void initState() {
    data = context.read<SessionBloc>().state.getFileTypeData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionBloc, SessionState>(
      listenWhen: (previous, current) {
        final bool listenWhen = previous.patientQuestionnaires.length !=
                current.patientQuestionnaires.length ||
            previous.receivedPatientQuestionnaires.length !=
                current.receivedPatientQuestionnaires.length;
        return !listenWhen;
      },
      listener: (context, state) {
        data = context.read<SessionBloc>().state.getFileTypeData;
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 60,
                  maxHeight: 60,
                ),
                child: PieChart(
                  PieChartData(
                    sections: getSections(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: kMediumPadding,
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data
                    .map(
                      (data) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: buildLegend(
                          percent: data.percent,
                          text: data.fileName == "Patient Questionnaire"
                              ? L.of(context).patientQuestionnaires
                              : L.of(context).receivedPatientQuestionnaire,
                          color: data.color,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildLegend({
    required double percent,
    required String text,
    required Color color,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  color: color,
                ),
                const SizedBox(
                  width: kSmallPadding,
                ),
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${percent.toStringAsFixed(0)}%",
            overflow: TextOverflow.ellipsis,
          )
        ],
      );
}
