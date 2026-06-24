import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/core/navigator/app_navigator.dart";

class BlocExampleItem {
  final String title;
  final String description;
  final VoidCallback onTap;
  final IconData icon;

  BlocExampleItem({
    required this.title,
    required this.description,
    required this.onTap,
    required this.icon,
  });
}

class HomeView extends StatelessWidget {
  final AppNavigator navigator;

  const HomeView({super.key, required this.navigator});

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;
    final items = <BlocExampleItem>[
      BlocExampleItem(
        title: i10n.blocExampleTimerTitle,
        description: i10n.blocExampleTimerDescription,
        onTap: () => navigator.openBlockTimerExample(),
        icon: Icons.timer,
      ),
      BlocExampleItem(
        title: i10n.blocExampleInfiniteScrollPostsTitle,
        description: i10n.blocExampleInfiniteScrollPostsDescription,
        onTap: () => navigator.openPostsList(),
        icon: Icons.list,
      ),
    ];

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
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.title),
              subtitle: Text(item.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: Icon(item.icon),
              onTap: item.onTap,
            );
          },
        ),
      ],
    );
  }
}
