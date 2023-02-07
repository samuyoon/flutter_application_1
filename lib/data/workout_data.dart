import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    // default workout
    Workout(
      name: "Upper Body",
      exercises: [
       Exercise(
        name: "Bicep Curls", 
        weight: "10", 
        reps: "10", 
        sets: "3",
        )
      ]
    ),
    Workout(
      name: "Lower Body",
      exercises: [
       Exercise(
        name: "Ham Curls", 
        weight: "10", 
        reps: "10", 
        sets: "3",
        )
      ]
    )
  ];
  
  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length of workout
  int numberOfExercisesInWorkout(workoutName){
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  // add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  // add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets) {
    //find the relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    // now that we've found the relevant workout, add the exercise data from the function inputs as a new exercise list item
    relevantWorkout.exercises.add(
      Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets)
    );

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
    Workout relevantWorkout = workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }
  // returns the relevant exercise object given the workout name and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = workoutList.firstWhere((workout) => workout.name == workoutName);
    Exercise relevantExercise = relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}