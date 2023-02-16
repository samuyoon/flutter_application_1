import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise_model.dart';
import 'package:flutter_application_1/models/set_model.dart';
import 'package:flutter_application_1/pages/homepage.dart';

import '../components/exercise_card.dart';
import '../constants.dart';
import '../models/workout_model.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // getExerciseList -- query supabase for exercises
  Future<List<Exercise>> _getExerciseList(workoutId) async {
    List<Exercise> exercises = [];
    final exerciseResponse =
        await supabase.from('exercises').select().eq('workout_id', workoutId);

    for (var map in exerciseResponse) {
      exercises.add(Exercise.fromMap(map));
    }
    return exercises;
  }

  // getSetList -- query supabase for sets
  Future<List<Set>> _getSetList(String exerciseId) async {
    List<Set> sets = [];
    final setResponse =
        await supabase.from('sets').select().eq('exercise_id', exerciseId);
    for (var map in setResponse) {
      sets.add(Set.fromMap(map));
    }
    return sets;
  }

  @override
  Widget build(BuildContext context) {
    final Workout workout =
        ModalRoute.of(context)?.settings.arguments as Workout;
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.workoutName),
      ),
      body: FutureBuilder<List<Exercise>>(
          future: _getExerciseList(workout.id),
          builder: (context, exerciseSnapshot) {
            if (exerciseSnapshot.hasData) {
              return Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: exerciseSnapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Column(
                        children: [
                          Text(exerciseSnapshot.data![index].exerciseName
                              .toString()),

                          // CODE BLOCK BELOW THIS LINE ALWAYS RETURNS CircularProgressIndicator()

                          FutureBuilder<List<Set>>(
                              future: _getSetList(
                                  exerciseSnapshot.data![index].id.toString()),
                              builder: (context, setSnapshot) {
                                if (setSnapshot.hasData) {
                                  ListView.builder(
                                      itemCount: setSnapshot.data!.length,
                                      itemBuilder: (context, index) =>
                                          Text(setSnapshot.data![index].type));
                                } else if (setSnapshot.hasError) {
                                  return Text('${setSnapshot.error}');
                                } else if (setSnapshot == null) {
                                  return Text('snapshot was null');
                                } else if (setSnapshot.connectionState ==
                                    ConnectionState.values) {
                                  return Text('connection state waiting');
                                }
                                return const CircularProgressIndicator();
                              }),
                          // CODE BLOCK ABOVE THIS LINE ALWAYS RETURNS CircularProgressIndicator()
                        ],
                      ));
                    }),
              );
            } else if (exerciseSnapshot.hasError) {
              return Text('${exerciseSnapshot.error}');
            } else if (exerciseSnapshot == null) {
              return Text('snapshot was null');
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
