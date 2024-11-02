import 'package:flutter/material.dart';

import '../../data/routes.dart';
import '../widgets/daily_progress_widget.dart';
import 'base_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Übersicht',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.pushNamed(context, Routes.settings);
          },
        ),
      ],
      body: const Column(
        children: [
          DailyFoodProgress(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addFood);
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
