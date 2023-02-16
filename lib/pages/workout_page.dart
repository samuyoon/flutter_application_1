import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/exercise_tile.dart';
import 'package:provider/provider.dart';
import '../data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({
    super.key, 
    required this.workoutName
    });
  
  final String workoutName;
    // text controller
  
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}


class _WorkoutPageState extends State<WorkoutPage> {

  final exerciseNameTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final repsTextController = TextEditingController();
  final setsTextController = TextEditingController();

  void createNewExercise() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('Add Exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //exerciseName, weight, reps, sets
            TextField(
              controller: exerciseNameTextController,
              decoration: const InputDecoration(
                hintText: 'exercise name', 
                border: InputBorder.none
                ),
              ),
            TextField(
              controller: weightTextController,
              decoration: const InputDecoration(
                hintText: 'weight', 
                border: InputBorder.none,
                ),
              ),
            TextField(
              controller: repsTextController,
              decoration: const InputDecoration(
                hintText: 'reps',
                border: InputBorder.none,
                ),
              ),
            TextField(
              controller: setsTextController,
              decoration: const InputDecoration(
                hintText: 'sets',
                border: InputBorder.none,
                ),
            ),
          ],
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
      )
      );
  }
  void save() {
    String exerciseName = exerciseNameTextController.text;
    String weight = weightTextController.text;
    String reps = repsTextController.text;
    String sets = setsTextController.text;
    
    Provider.of<WorkoutData>(context, listen: false).addExercise(widget.workoutName, exerciseName, weight, reps, sets);
    Navigator.pop(context);
    clear();
  }
  
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameTextController.clear();
    weightTextController.clear();
    repsTextController.clear();
    setsTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(

          title: Text(widget.workoutName),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: const Icon(Icons.add),
          ), 
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value.getRelevantWorkout(widget.workoutName).exercises[index].name, 
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight, 
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted,
            onCheckboxChange: (val) => value
                .checkOffExercise(
                  value.getRelevantWorkout(widget.workoutName).name, 
                  value.getRelevantWorkout(widget.workoutName).exercises[index].name
                ),
      ),
    )
    )
    );
  }
}
 
