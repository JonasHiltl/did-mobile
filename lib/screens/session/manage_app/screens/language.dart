import 'package:did/generated/l10n.dart';
import 'package:did/providers/app_settings/app_settings_bloc.dart';
import 'package:did/providers/app_settings/app_settings_event.dart';
import 'package:did/providers/app_settings/app_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              // if floating is true the appbar becomes instantly visible if scrolled towards top
              // if it's false the appbar is only visible if completly scrolled back to top
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                L.of(context).languages,
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: kMediumPadding,
                vertical: kSmallPadding,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    InkWell(
                      onTap: () => context.read<AppSettingsBloc>().add(
                            LanguageChanged(
                              language: "en",
                            ),
                          ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF1F3FD),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6))),
                        child: Row(
                          children: [
                            Radio(
                              value: "en",
                              groupValue: state.language,
                              onChanged: (value) =>
                                  context.read<AppSettingsBloc>().add(
                                        LanguageChanged(
                                          language: value.toString(),
                                        ),
                                      ),
                              activeColor: Theme.of(context).primaryColor,
                            ),
                            const Text("English"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: kSmallPadding,
                    ),
                    InkWell(
                      onTap: () => context.read<AppSettingsBloc>().add(
                            LanguageChanged(
                              language: "de",
                            ),
                          ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF1F3FD),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                color:
                                    const Color(0xFFACB6C5).withOpacity(0.6))),
                        child: Row(
                          children: [
                            Radio(
                              value: "de",
                              groupValue: state.language,
                              onChanged: (value) =>
                                  context.read<AppSettingsBloc>().add(
                                        LanguageChanged(
                                          language: value.toString(),
                                        ),
                                      ),
                              activeColor: Theme.of(context).primaryColor,
                            ),
                            const Text("Deutsch"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
