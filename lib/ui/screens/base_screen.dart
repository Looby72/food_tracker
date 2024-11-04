import 'package:flutter/material.dart';

// Base Widget for all screens in the app.
class Screen extends StatelessWidget {
  const Screen(
      {super.key,
      this.title = 'Screen',
      this.centerTitle = true,
      this.actions,
      this.body,
      this.floatingActionButton});

  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
        centerTitle: centerTitle,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: actions,
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: body),
      floatingActionButton: floatingActionButton,
    );
  }
}
