import 'package:besser/bloc/meal_intake_cubit.dart';
import 'package:besser/main.dart';
import 'package:besser/screens/chip.dart';
import 'package:besser/screens/meal_intake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsList extends StatelessWidget {
  const MealsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<MealIntakeReadonly> meals = [
      MealIntakeReadonly(
        date: DateTime(2024, 12, 25),
        time: const TimeOfDay(hour: 19, minute: 0),
        expanded: true,
        note: 'Christmas dinner with family',
        ingredients: ['Turkey', 'Mashed Potatoes', 'Gravy', 'Cranberry Sauce'],
      ),
      MealIntakeReadonly(
        date: DateTime(2024, 11, 24), // Thanksgiving lunch
        time: TimeOfDay(hour: 13, minute: 0),
        expanded: false,
        note: 'Thanksgiving lunch with friends',
        ingredients: ['Roast Turkey', 'Stuffing', 'Pumpkin Pie'],
      ),
      MealIntakeReadonly(
        date: DateTime(2024, 10, 31), // Halloween snack
        time: TimeOfDay(hour: 16, minute: 30),
        expanded: true,
        note: 'Halloween snack party',
        ingredients: ['Candy', 'Chocolate Bars', 'Cupcakes'],
      ),
      MealIntakeReadonly(
        date: DateTime(2024, 7, 4), // Independence Day BBQ
        time: TimeOfDay(hour: 18, minute: 0),
        expanded: false,
        note: 'BBQ party with neighbors',
        ingredients: ['Grilled Chicken', 'Corn on the Cob', 'Potato Salad'],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: meals.map((e) {
              return ListTile(
                onTap: (){
                context.read<MealIntakeCubit>().setReadOnlyState(e);
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const BesserEsser()));
                },
                leading: Column(
                  children: [
                    Icon(Icons.no_food_outlined),
                    Text('${e.time?.hour.toString()} ${e.time?.minute.toString()}')
                  ],
                ),
                title: Wrap(
                  runSpacing: 4,
                  children: e.ingredients!.map((element){
                    return MyChip(text: element, state: false, onTap: () {  },);
                  }).toList(),
                ),
                subtitle: Text(e.note ?? ''),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: IconButton(onPressed: (){
        context.read<MealIntakeCubit>().setEditState();
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const BesserEsser()));
      }, icon: Icon(Icons.add_box_outlined)),
    );
  }
}
