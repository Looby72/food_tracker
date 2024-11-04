import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/settings_controller.dart';

class SettingsThemeWidget extends StatelessWidget {
  const SettingsThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);

    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Darstellung',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            const SizedBox(height: 8),
            RadioListTile<ThemeMode>(
              title: Text('Hell',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)),
              value: ThemeMode.light,
              groupValue: settingsController.themeMode,
              onChanged: (ThemeMode? value) {
                settingsController.updateThemeMode(value);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            RadioListTile<ThemeMode>(
              title: Text('Dunkel',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)),
              value: ThemeMode.dark,
              groupValue: settingsController.themeMode,
              onChanged: (ThemeMode? value) {
                settingsController.updateThemeMode(value);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            RadioListTile<ThemeMode>(
              title: Text('System',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)),
              value: ThemeMode.system,
              groupValue: settingsController.themeMode,
              onChanged: (ThemeMode? value) {
                settingsController.updateThemeMode(value);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
