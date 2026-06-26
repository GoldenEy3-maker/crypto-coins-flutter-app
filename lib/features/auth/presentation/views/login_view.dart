import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";

import "../widgets/widgets.dart";

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Text(i10n.login, style: theme.textTheme.titleLarge),
        const SizedBox(height: 24),
        const LoginForm(),
      ],
    );
  }
}
