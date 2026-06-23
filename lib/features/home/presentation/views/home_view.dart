import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.minHeight),
                child: Center(
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.homeTitleWithValue("Cryptocurrencies"),
                    style: const TextStyle(fontSize: 24, fontWeight: .w700),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
