import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'meal_intake_state.dart';

class MealIntakeCubit extends Cubit<MealIntakeState> {
  MealIntakeCubit() : super(const MealIntakeEdit());

  void setDate(DateTime date) {
    emit((state as MealIntakeEdit).copyWith(date: date));
  }


  void setTime(TimeOfDay time){
    emit((state as MealIntakeEdit).copyWith(time:time));
  }

  void setIngredients(String ing){
    List<String>? newIngredients;
    if(state.ingredients != null){
      newIngredients = List.from(state.ingredients!)..add(ing);
    }else{
      newIngredients = [ing];
    }
    emit((state as MealIntakeEdit).copyWith(ingredients:newIngredients));
  }

  void setNote(String txt){
    emit((state as MealIntakeEdit).copyWith(note: txt));
  }

  void setReadOnlyState(MealIntakeState inst){
    emit(MealIntakeReadonly(
        date: inst.date,
        time: inst.time,
        ingredients: inst.ingredients,
        note: inst.note
    ));
  }

  void setEditState({MealIntakeState? inst}){
    if(inst == null){
      emit(MealIntakeEdit(
        date: DateTime.now(),
        time: TimeOfDay.now()
      ));
    }else{
      emit(MealIntakeEdit(
          date: inst.date,
          time: inst.time,
          ingredients: inst.ingredients,
          note: inst.note
      ));
    }
  }

  List<String> ingredients = [
    'Chicken Breast',
    'Ground Beef',
    'Salmon',
    'Shrimp',
    'Tofu',
    'Eggs',
    'Bacon',
    'Pork Chops',
    'Turkey',
    'Tuna',
    'Quinoa',
    'Brown Rice',
    'White Rice',
    'Lentils',
    'Chickpeas',
    'Black Beans',
    'Kidney Beans',
    'Broccoli',
    'Spinach',
    'Kale',
    'Carrots',
    'Bell Peppers',
    'Tomatoes',
    'Zucchini',
    'Cucumbers',
    'Avocado',
    'Potatoes',
    'Sweet Potatoes',
    'Onions',
    'Garlic',
    'Mushrooms',
    'Green Beans',
    'Cauliflower',
    'Peas',
    'Corn',
    'Cabbage',
    'Brussels Sprouts',
    'Asparagus',
    'Eggplant',
    'Beets',
    'Radishes',
    'Lettuce',
    'Arugula',
    'Cilantro',
    'Basil',
    'Parsley',
    'Rosemary',
    'Thyme',
    'Oregano',
    'Dill',
    'Ginger',
    'Turmeric',
    'Black Pepper',
    'Red Pepper Flakes',
    'Cumin',
    'Paprika',
    'Chili Powder',
    'Cinnamon',
    'Nutmeg',
    'Vanilla Extract',
    'Olive Oil',
    'Coconut Oil',
    'Vegetable Oil',
    'Sesame Oil',
    'Soy Sauce',
    'Teriyaki Sauce',
    'BBQ Sauce',
    'Hot Sauce',
    'Honey',
    'Maple Syrup',
    'Peanut Butter',
    'Almond Butter',
    'Jelly',
    'Bread',
    'Tortillas',
    'Pasta',
    'Couscous',
    'Flour',
    'Sugar',
    'Brown Sugar',
    'Baking Powder',
    'Baking Soda',
    'Yeast',
    'Milk',
    'Almond Milk',
    'Coconut Milk',
    'Heavy Cream',
    'Yogurt',
    'Cheese',
    'Parmesan',
    'Feta Cheese',
    'Mozzarella',
    'Sour Cream',
    'Cream Cheese',
    'Nuts (e.g., almonds, walnuts, cashews)',
    'Seeds (e.g., chia seeds, flaxseeds, pumpkin seeds)',
    'Dried Fruits (e.g., raisins, cranberries, apricots)',
    'Dark Chocolate',
    'Ice Cream',
    'Granola',
  ];

  void getSuggestions(String text){
    List<String>? suggests = ingredients.where((ing){
      return ing.toLowerCase().contains(text);
    }).toList();
    emit((state as MealIntakeEdit).copyWith(suggestions: suggests));
  }

  void removeIngredients(String text){
    List<String>? newIng = List.from(state.ingredients!)..remove(text);
    emit((state as MealIntakeEdit).copyWith(ingredients: newIng));
  }

}
