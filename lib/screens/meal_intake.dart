import 'package:besser/bloc/meal_intake_cubit.dart';
import 'package:besser/screens/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BesserEsser extends StatelessWidget {
  const BesserEsser({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return BlocBuilder<MealIntakeCubit, MealIntakeState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xff49b38a),
          title: const Text(
            'Meal Intake',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (state is MealIntakeReadonly) {
                    context.read<MealIntakeCubit>().setEditState(inst: state);
                  } else {
                    context.read<MealIntakeCubit>().setReadOnlyState(state);
                  }
                },
                icon: Icon(
                  state is MealIntakeReadonly ? Icons.edit : Icons.check,
                  color: Colors.white,
                ))
          ],
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: const Color(0xff49b38a), width: 3)),
                          child: const Icon(
                            Icons.restaurant,
                            size: 28,
                            color: Color(0xff49b38a),
                          )),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xff9aa19e),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 0.8)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Datum und Uhrzeit',
                          style: TextStyle(fontSize: 26),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (state is! MealIntakeReadonly) {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    context
                                        .read<MealIntakeCubit>()
                                        .setDate(pickedDate);
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 50),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: state is MealIntakeReadonly
                                          ? Colors.transparent
                                          : const Color(0xff9aa19e),
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      color: Color(0xff49b38a),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      state.date != null ? '${state.date!.month}-${state.date!.day.toString()}' : '',
                                      style:
                                          const TextStyle(color: Color(0xff49b38a)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (state is! MealIntakeReadonly) {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    context
                                        .read<MealIntakeCubit>()
                                        .setTime(pickedTime);
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 50),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: state is MealIntakeReadonly
                                          ? Colors.transparent
                                          : const Color(0xff9aa19e),
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Color(0xff49b38a),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      state.time != null ? '${state.time!.hour}:${state.time!.minute}' : '',
                                      style: const TextStyle(
                                          color: Color(0xff49b38a)),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xff9aa19e),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 0.8)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Zutatn und Getranke',
                          style: TextStyle(fontSize: 26),
                        ),
                        if(state.ingredients != null)
                          Wrap(
                              runSpacing: 5,
                              children: state.ingredients!.map((e) {
                                return MyChip(
                                  text: e,
                                  state: state is MealIntakeEdit, onTap: () {
                                    context.read<MealIntakeCubit>().removeIngredients(e);
                                },
                                );
                              }).toList(),
                            ),
                        Visibility(
                          visible: state is MealIntakeEdit,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const ExpansionTile(
                                leading: Icon(
                                  Icons.info_outline,
                                ),
                                title: Text('Hinweise zur Eingabe: '),
                                tilePadding: EdgeInsets.zero,
                                shape: Border.symmetric(
                                  horizontal: BorderSide(
                                      width: 0.5, color: Color(0xffb9bdbb)),
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    showDragHandle: true,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: BlocBuilder<MealIntakeCubit,
                                            MealIntakeState>(
                                          builder: (context, state) {
                                            return Column(
                                              children: [
                                                TextField(
                                                  controller: controller,
                                                  autofocus: true,
                                                  onChanged: (text) {
                                                    if (text.length > 1) {
                                                      context
                                                          .read<
                                                              MealIntakeCubit>()
                                                          .getSuggestions(text);
                                                    }
                                                  },
                                                ),
                                                if (controller.text.length >
                                                        1 &&
                                                    state is MealIntakeEdit &&
                                                    state.suggestions != null)
                                                  Container(
                                                    height: 300,
                                                    child: ListView.builder(
                                                      itemCount: state
                                                          .suggestions?.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ListTile(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    MealIntakeCubit>()
                                                                .setIngredients(
                                                                    state.suggestions![
                                                                        index]);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          title: Text(state
                                                                  .suggestions![
                                                              index]),
                                                        );
                                                      },
                                                    ),
                                                  )
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xff9aa19e),
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Center(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle_rounded,
                                          color: Color(0xff49b38a),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          'Zutat hinzufugen',
                                          style: TextStyle(
                                              color: Color(0xff49b38a)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xff9aa19e),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 0.8)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notiz',
                          style: TextStyle(fontSize: 26),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        BlocBuilder<MealIntakeCubit, MealIntakeState>(builder: (context, state){
                          return TextField(
                            enabled: state is MealIntakeEdit,
                            minLines: 1,
                            maxLines: 4,
                            onChanged: (txt){
                              context.read<MealIntakeCubit>().setNote(txt);
                            },
                          );
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                            'wird bei der allergen-analyse nicht berucksichtigt')
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Visibility(
                    visible: state is MealIntakeEdit,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff9aa19e),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        color: const Color(0xff49b38a)
                      ),
                      child: const Center(
                        child: Wrap(
                          crossAxisAlignment:
                          WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Zutat hinzufugen',
                              style: TextStyle(
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
