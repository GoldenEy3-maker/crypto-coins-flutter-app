import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";

class HomeView extends StatelessWidget {
  final AppNavigator navigator;

  const HomeView({super.key, required this.navigator});

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const .only(top: 16, left: 16, bottom: 4, right: 16),
            child: Text(
              i10n.blocExamples,
              style: const TextStyle(fontSize: 18, fontWeight: .w500),
            ),
          ),
        ),
        SliverList.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(i10n.blocExampleTimerTitle),
              subtitle: Text(i10n.blocExampleTimerDescription),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: const Icon(Icons.timer),
              onTap: () => navigator.openBlockTimerExample(),
            );
          },
        ),
      ],
    );
  }
}
