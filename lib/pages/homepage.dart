import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/exercise_card.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:flutter_application_1/models/workout_model.dart';
import 'package:flutter_application_1/pages/workout_page.dart';
import 'package:flutter_application_1/pages/x_workout_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/exercise_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // supabase stream builder
  final _workoutsStream =
      Supabase.instance.client.from('workouts').stream(primaryKey: ['id']);

  // create new workout
  void createNewWorkout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('this is a title'),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('cancel'),
          ),
        ],
      ),
    );
  }

  // text controller
  final newWorkoutNameController = TextEditingController();

  // add a workout to supabase db
  void addWorkoutSupabase(String name) async {
    await Supabase.instance.client
        .from('workouts')
        .insert({'workout_name': name});
  }

  // save workout
  void save() {
    // get workout name from text controller and save in var
    String newWorkoutName = newWorkoutNameController.text;
    // add the workout and the workoutName property to the initialized WorkoutData object (not the class)
    addWorkoutSupabase(newWorkoutName);
    setState(() {});
    Navigator.pop(context);
    clear();
  }

  // cancel workout
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear contents of text controller
  void clear() {
    newWorkoutNameController.clear();
  }

  // getWorkoutList -- query supabase for workouts based on query parameters, convert JSON object to Flutter-usable object
  Future<List<Workout>> getWorkoutList() async {
    List<Workout> workouts = [];

    final List<Map<String, dynamic>> workoutResponse =
        await supabase.from('workouts').select();

    for (var map in workoutResponse) {
      workouts.add(Workout.fromMap(map));
    }

    return workouts;
  }

  // getExerciseList -- query supabase for workouts based on query parameters, convert JSON object to Flutter-usable object
  Future<List<Exercise>> getExerciseList(workoutId) async {
    List<Exercise> exercises = [];

    final exerciseResponse =
        await supabase.from('exercises').select().eq('workout_id', workoutId);

    for (var map in exerciseResponse) {
      exercises.add(Exercise.fromMap(map));
    }
    return exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('workout overview page'),
        ),
        body: FutureBuilder<List<Workout>>(
          future: getWorkoutList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, workoutListIndex) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkoutPage(),
                        settings: RouteSettings(
                            arguments: snapshot.data![workoutListIndex]),
                      ),
                    ),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(snapshot
                                .data![workoutListIndex].workoutName
                                .toString()),
                          ),
                          FutureBuilder<List<Exercise>>(
                              future: getExerciseList(snapshot
                                  .data![workoutListIndex].id
                                  .toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) => Chip(
                                            // figure out how to get the chips to run in a row
                                            label: Text(snapshot
                                                .data![index].exerciseName))),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              }),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
