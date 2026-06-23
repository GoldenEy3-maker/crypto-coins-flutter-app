import "package:flutter/material.dart";
import "package:flutter_application_1/core/theme/app_brightness.dart";
import "package:flutter_application_1/core/theme/app_brightness_theme_label_resolver.dart";
import "package:flutter_application_1/core/theme/theme_provider.dart";

class ChangeThemeBottomSheet extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ChangeThemeBottomSheet({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final appBrightnessThemeLabelResolver =
        AppBrightnessThemeLabelResolver.fromContext(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ).copyWith(top: 16),
            child: Row(
              children: [
                const Icon(Icons.palette_outlined),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Тема",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Выберите цветовую тему приложения",
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
          ListTile(
            leading: const Icon(Icons.light_mode),
            title: Text(
              appBrightnessThemeLabelResolver.resolve(AppBrightness.light),
            ),
            onTap: () {
              themeProvider.setTheme(AppBrightness.light);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(
              appBrightnessThemeLabelResolver.resolve(AppBrightness.dark),
            ),
            onTap: () {
              themeProvider.setTheme(AppBrightness.dark);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.system_update_alt),
            title: Text(
              appBrightnessThemeLabelResolver.resolve(AppBrightness.system),
            ),
            onTap: () {
              themeProvider.setTheme(AppBrightness.system);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
