import 'package:shared_preferences/shared_preferences.dart';

class NutrientGoalService {
  static const String energyGoalKey = 'energyGoal';
  static const String proteinGoalKey = 'proteinGoal';
  static const String fatGoalKey = 'fatGoal';
  static const String carbGoalKey = 'carbGoal';

  Future<void> saveEnergyGoal(int energyGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(energyGoalKey, energyGoal);
  }

  Future<void> saveProteinGoal(int proteinGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(proteinGoalKey, proteinGoal);
  }

  Future<void> saveFatGoal(int fatGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(fatGoalKey, fatGoal);
  }

  Future<void> saveCarbGoal(int carbGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(carbGoalKey, carbGoal);
  }

  Future<Map<String, int>> loadNutrientGoals() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      energyGoalKey: prefs.getInt(energyGoalKey) ?? 11000,
      proteinGoalKey: prefs.getInt(proteinGoalKey) ?? 140,
      fatGoalKey: prefs.getInt(fatGoalKey) ?? 70,
      carbGoalKey: prefs.getInt(carbGoalKey) ?? 300,
    };
  }
}
