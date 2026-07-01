import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/features/auth/domain/usecases/usecases.dart";
import "package:flutter_application_1/features/auth/presentation/views/test_sandbox_refresh_tokens_view.dart";

@RoutePage()
class TestSandboxRefreshTokensPage extends StatelessWidget {
  const TestSandboxRefreshTokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(i10n.testSandboxRefreshTokensTitle)),
      body: TestSandboxRefreshTokensView(
        testSandboxRefreshTokensFetch: getIt
            .get<TestSandboxRefreshTokensFetch>(),
      ),
    );
  }
}
