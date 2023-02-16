/*
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise_model.dart';
import 'package:flutter_application_1/models/workout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class xWorkoutData extends ChangeNotifier {
  // add a workout -- EVENTUALLY DEPRECATE
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  // add a workout to supabase db
  void addWorkoutSupabase(String name) async {
    await Supabase.instance.client
        .from('workouts')
        .insert({'workout_name': name});

    notifyListeners();
  }

  // add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //find the relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    // now that we've found the relevant workout, add the exercise data from the function inputs as a new exercise list item
    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));

    notifyListeners();
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  // returns the relevant workout object given the workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  // returns the relevant exercise object given the workout name and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
*/