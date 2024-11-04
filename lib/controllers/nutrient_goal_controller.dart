import 'package:flutter/material.dart';

import '../services/settings_service.dart';

class NutrientGoalController with ChangeNotifier {
  final SettingsService _service = SettingsService();

  late int _energyGoal = 0;
  late int _proteinGoal = 0;
  late int _fatGoal = 0;
  late int _carbGoal = 0;

  int get energyGoal => _energyGoal;
  int get proteinGoal => _proteinGoal;
  int get fatGoal => _fatGoal;
  int get carbGoal => _carbGoal;

  NutrientGoalController() {
    loadNutrientGoals();
  }

  Future<void> loadNutrientGoals() async {
    // Load the nutrient goals from a service
    final goals = await _service.loadNutrientGoals();
    _energyGoal = goals['energy']!;
    _proteinGoal = goals['proteins']!;
    _fatGoal = goals['fats']!;
    _carbGoal = goals['carbs']!;

    notifyListeners();
  }

  void updateEnergyGoal(int newGoal) {
    _energyGoal = newGoal;
    _service.saveEnergyGoal(newGoal);
    notifyListeners();
  }

  void updateProteinGoal(int newGoal) {
    _proteinGoal = newGoal;
    _service.saveProteinGoal(newGoal);
    notifyListeners();
  }

  void updateFatGoal(int newGoal) {
    _fatGoal = newGoal;
    _service.saveFatGoal(newGoal);
    notifyListeners();
  }

  void updateCarbGoal(int newGoal) {
    _carbGoal = newGoal;
    _service.saveCarbGoal(newGoal);
    notifyListeners();
  }
}
