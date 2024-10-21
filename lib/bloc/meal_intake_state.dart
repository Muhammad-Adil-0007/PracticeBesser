part of 'meal_intake_cubit.dart';

@immutable
abstract class MealIntakeState {
  final DateTime? date;
  final TimeOfDay? time;
  final bool? expanded;
  final String? note;
  final List<String>? ingredients;

  const MealIntakeState({
    this.date,
    this.time,
    this.expanded,
    this.note,
    this.ingredients,
  });
}

final class MealIntakeReadonly extends MealIntakeState {
  const MealIntakeReadonly({
    super.date,
    super.time,
    super.expanded,
    super.note,
    super.ingredients,
  });

  MealIntakeReadonly copyWith({
    DateTime? date,
    TimeOfDay? time,
    bool? expanded,
    String? note,
    List<String>? ingredients,
  }) {
    return MealIntakeReadonly(
      date: date ?? this.date,
      time: time ?? this.time,
      expanded: expanded ?? this.expanded,
      note: note ?? this.note,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}

final class MealIntakeEdit extends MealIntakeState {
  final List<String>? suggestions;
  const MealIntakeEdit({
    this.suggestions,
    super.date,
    super.time,
    super.expanded,
    super.note,
    super.ingredients,
  });

  MealIntakeEdit copyWith({
    DateTime? date,
    TimeOfDay? time,
    bool? expanded,
    String? note,
    List<String>? ingredients,
    List<String>? suggestions,
  }) {
    return MealIntakeEdit(
      date: date ?? this.date,
      time: time ?? this.time,
      expanded: expanded ?? this.expanded,
      note: note ?? this.note,
      ingredients: ingredients ?? this.ingredients,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}

final class MealIntakes extends MealIntakeState{
  
}