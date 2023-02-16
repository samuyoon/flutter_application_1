 
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckboxChange;

  ExerciseTile({
    super.key,
    required this.exerciseName, 
    required this.weight,
    required this.reps, 
    required this.sets, 
    required this.isCompleted,
    required this.onCheckboxChange,
    });


  @override
  Widget build(BuildContext context) {
    return Container(
            color: Colors.grey,
            child: ListTile(
              title: Text(exerciseName),
              trailing: Checkbox(
                value: isCompleted,
                onChanged: (value) => onCheckboxChange!(value),
              ),
              subtitle: Row(
                children: [
                  Chip(
                    label: Text(
                      '$weight kgs'
                    ),
                    ),
                  Chip(
                    label: Text(
                      '$reps reps'
                    ),
                    ),
                  Chip(
                    label: Text(
                      '$sets sets'
                    ),
                    ),
                ],
              ),
            ),
      );
  }
}
