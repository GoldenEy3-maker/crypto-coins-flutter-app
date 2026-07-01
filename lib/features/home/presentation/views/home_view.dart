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
  final AppNavigator _appNavigator;

  const HomeView({super.key, required AppNavigator appNavigator})
    : _appNavigator = appNavigator;

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;
    final blocExampleItems = <BlocExampleItem>[
      BlocExampleItem(
        title: i10n.blocExampleTimerTitle,
        description: i10n.blocExampleTimerDescription,
        onTap: () => _appNavigator.openBlockTimerExample(),
        icon: Icons.timer,
      ),
      BlocExampleItem(
        title: i10n.blocExampleInfiniteScrollPostsTitle,
        description: i10n.blocExampleInfiniteScrollPostsDescription,
        onTap: () => _appNavigator.openPostsList(),
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
          itemCount: blocExampleItems.length,
          itemBuilder: (context, index) {
            final blocExampleItem = blocExampleItems[index];
            return ListTile(
              title: Text(blocExampleItem.title),
              subtitle: Text(blocExampleItem.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              leading: Icon(blocExampleItem.icon),
              onTap: blocExampleItem.onTap,
            );
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const .only(top: 16, left: 16, bottom: 4, right: 16),
            child: Text(
              i10n.testSandboxRefreshTokensExample,
              style: const TextStyle(fontSize: 18, fontWeight: .w500),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(i10n.testSandboxRefreshTokensExample),
            leading: const Icon(Icons.refresh),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _appNavigator.openTestSandboxRefreshTokens(),
          ),
        ),
      ],
    );
  }
}
