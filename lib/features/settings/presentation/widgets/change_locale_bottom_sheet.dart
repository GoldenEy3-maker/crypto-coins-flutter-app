import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/language.dart";
import "package:flutter_application_1/core/l10n/locale_provider.dart";

class ChangeLocaleBottomSheet extends StatelessWidget {
  final LocaleProvider localeProvider;

  const ChangeLocaleBottomSheet({super.key, required this.localeProvider});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(top: 16),
            child: Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Язык",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Выберите язык приложения",
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverList.list(
                children: Language.languageList()
                    .map(
                      (language) => ListTile(
                        title: Text(language.name),
                        onTap: () {
                          localeProvider.setLocale(language.locale);
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
