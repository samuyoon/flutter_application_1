import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  // text controller
  final newWorkoutNameController = TextEditingController();

  // create new workout
  void createNewWorkout(){
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
  // save workout
  void save() {
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutNameController.text);
  }
  
  // cancel workout
  void cancel() {

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Workout Tracker'),
        ),
        body: ListView.builder(
          itemCount: value.getWorkoutList().length,
          itemBuilder: (context, index) => ListTile(
            title: Text(value.getWorkoutList()[index].name),
          ),  
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
          ),
      ),
    );
  }
}