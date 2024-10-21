
import 'package:besser/bloc/meal_intake_cubit.dart';
import 'package:besser/screens/meal_intake.dart';
import 'package:besser/screens/meals_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() async{
  // await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MealIntakeCubit>(
      create: (context) => MealIntakeCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MealsList(),
      ),
    );
  }
}

