import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//A class to store and retrieve the settings from the Phones storage
//The shared preferences package is used.
class SettingsService {
  //Keys for every Settings value
  static const String _energyGoalKey = 'energyGoal';
  static const String _proteinGoalKey = 'proteinGoal';
  static const String _fatGoalKey = 'fatGoal';
  static const String _carbGoalKey = 'carbGoal';
  static const String _themeModeKey = 'themeMode';

  /// Saves the energy goal to shared preferences.
  ///
  /// Takes an integer [energyGoal] which represents the energy goal in calories.
  ///
  /// Example:
  /// ```dart
  /// await saveEnergyGoal(2000);
  /// ```
  Future<void> saveEnergyGoal(int energyGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_energyGoalKey, energyGoal);
  }

  /// Saves the protein goal to shared preferences.
  ///
  /// Takes an integer [proteinGoal] which represents the protein goal in grams.
  ///
  /// Example:
  /// ```dart
  /// await saveProteinGoal(150);
  /// ```
  Future<void> saveProteinGoal(int proteinGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_proteinGoalKey, proteinGoal);
  }

  /// Saves the fat goal to shared preferences.
  ///
  /// Takes an integer [fatGoal] which represents the fat goal in grams.
  ///
  /// Example:
  /// ```dart
  /// await saveFatGoal(70);
  /// ```
  Future<void> saveFatGoal(int fatGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_fatGoalKey, fatGoal);
  }

  /// Saves the carbohydrate goal to shared preferences.
  ///
  /// Takes an integer [carbGoal] which represents the carbohydrate goal in grams.
  ///
  /// Example:
  /// ```dart
  /// await saveCarbGoal(250);
  /// ```
  Future<void> saveCarbGoal(int carbGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_carbGoalKey, carbGoal);
  }

  /// Loads the nutrient goals from shared preferences.
  ///
  /// Returns a [Map<String, int>] containing the nutrient goals in the
  /// following format:
  /// ```dart
  /// {
  ///   "energy": 11000,
  ///   "proteins": 140,
  ///   "fats": 70,
  ///   "carbs": 300,
  /// }
  /// ```
  ///
  /// Example:
  /// ```dart
  /// Map<String, int> goals = await loadNutrientGoals();
  /// ```
  Future<Map<String, int>> loadNutrientGoals() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "energy": prefs.getInt(_energyGoalKey) ?? 11000,
      "proteins": prefs.getInt(_proteinGoalKey) ?? 140,
      "fats": prefs.getInt(_fatGoalKey) ?? 70,
      "carbs": prefs.getInt(_carbGoalKey) ?? 300,
    };
  }

  /// Loads the user's preferred ThemeMode from shared preferences.
  ///
  /// Returns a [Future] that completes with the [ThemeMode] set by the user.
  Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final int? themeModeInt = prefs.getInt(_themeModeKey);
    return ThemeMode.values[themeModeInt ?? ThemeMode.system.index];
  }

  /// Persists the user's preferred ThemeMode to shared preferences.
  ///
  /// Takes a [ThemeMode] which represents the user's preferred theme.
  ///
  /// Returns:
  /// A [Future] that completes when the ThemeMode has been saved.
  ///
  /// Example:
  /// ```dart
  /// await updateThemeMode(ThemeMode.dark);
  /// ```
  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, theme.index);
  }
}
