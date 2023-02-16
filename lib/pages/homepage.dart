import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:flutter_application_1/pages/workout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  // text controller
  final newWorkoutNameController = TextEditingController();

  //goToWorkoutPage
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
        ),
      );
  }
  
  
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
    // get workout name from text controller and save in var
    String newWorkoutName = newWorkoutNameController.text;
    // add the workout and the workoutName property to the initialized WorkoutData object (not the class)
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
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

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ),
        body: ListView.builder(
          itemCount: value.getWorkoutList().length,
          itemBuilder: (context, index) => ListTile(
            title: Text(value.getWorkoutList()[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name),
            ),
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