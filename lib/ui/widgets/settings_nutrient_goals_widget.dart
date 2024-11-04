import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/nutrient_goal_controller.dart';

class SettingsNutrientGoals extends StatefulWidget {
  const SettingsNutrientGoals({super.key});

  @override
  State<SettingsNutrientGoals> createState() => _SettingsNutrientGoalsState();
}

class _SettingsNutrientGoalsState extends State<SettingsNutrientGoals> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController energyController;
  late TextEditingController proteinController;
  late TextEditingController fatController;
  late TextEditingController carbController;

  @override
  void initState() {
    super.initState();
    final nutrientController =
        Provider.of<NutrientGoalController>(context, listen: false);
    energyController =
        TextEditingController(text: nutrientController.energyGoal.toString());
    proteinController =
        TextEditingController(text: nutrientController.proteinGoal.toString());
    fatController =
        TextEditingController(text: nutrientController.fatGoal.toString());
    carbController =
        TextEditingController(text: nutrientController.carbGoal.toString());
  }

  @override
  void dispose() {
    energyController.dispose();
    proteinController.dispose();
    fatController.dispose();
    carbController.dispose();
    super.dispose();
  }

  String? _goalValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Bitte geben Sie einen Wert ein';
    } else if (int.tryParse(value) == null) {
      return 'Bitte geben Sie einen ganzzahligen Wert ein';
    } else if (int.parse(value) < 0) {
      return 'Bitte geben Sie einen positiven Wert ein';
    }
    return null;
  }

  void _saveGoals() {
    if (_formKey.currentState!.validate()) {
      final nutrientController =
          Provider.of<NutrientGoalController>(context, listen: false);
      nutrientController.updateEnergyGoal(int.parse(energyController.text));
      nutrientController.updateProteinGoal(int.parse(proteinController.text));
      nutrientController.updateFatGoal(int.parse(fatController.text));
      nutrientController.updateCarbGoal(int.parse(carbController.text));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Nährstoffziele gespeichert'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(32),
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nährstoffziele',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: energyController,
                    decoration:
                        const InputDecoration(labelText: 'Energie (kcal)'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    keyboardType: TextInputType.number,
                    validator: _goalValidator,
                  ),
                  TextFormField(
                    controller: proteinController,
                    decoration:
                        const InputDecoration(labelText: 'Proteine (g)'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    keyboardType: TextInputType.number,
                    validator: _goalValidator,
                  ),
                  TextFormField(
                    controller: fatController,
                    decoration: const InputDecoration(labelText: 'Fett (g)'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    keyboardType: TextInputType.number,
                    validator: _goalValidator,
                  ),
                  TextFormField(
                    controller: carbController,
                    decoration:
                        const InputDecoration(labelText: 'Kohlenhydrate (g)'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    keyboardType: TextInputType.number,
                    validator: _goalValidator,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: _saveGoals, child: const Text('Speichern'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
