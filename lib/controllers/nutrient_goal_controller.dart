import 'package:flutter/material.dart';

import '../services/nutrient_goal_service.dart';

class NutrientGoalController with ChangeNotifier {
  late int _calorieGoal;
  late int _proteinGoal;
  late int _fatGoal;
  late int _carbGoal;

  final NutrientGoalService _service = NutrientGoalService();

  int get calorieGoal => _calorieGoal;
  int get proteinGoal => _proteinGoal;
  int get fatGoal => _fatGoal;
  int get carbGoal => _carbGoal;

  NutrientGoalController() {
    loadNutrientGoals();
  }

  Future<void> loadNutrientGoals() async {
    // Load the nutrient goals from a service
    final goals = await _service.loadNutrientGoals();
    _calorieGoal = goals[NutrientGoalService.calorieGoalKey]!;
    _proteinGoal = goals[NutrientGoalService.proteinGoalKey]!;
    _fatGoal = goals[NutrientGoalService.fatGoalKey]!;
    _carbGoal = goals[NutrientGoalService.carbGoalKey]!;

    notifyListeners();
  }

  void updateCalorieGoal(int newGoal) {
    _calorieGoal = newGoal;
    _service.saveCalorieGoal(newGoal);
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
