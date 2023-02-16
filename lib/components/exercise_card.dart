import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/set_model.dart';
import 'package:flutter_application_1/models/exercise_model.dart';

import '../constants.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  //final String exerciseName;
  //final String? targetLoad;
  //final String sets;
  //final String? targetReps;
  //final String? exerciseRiR;

  ExerciseCard({
    super.key,
    required this.exercise,
    //required this.exerciseName,
    //this.targetLoad,
    //required this.sets,
    //this.targetReps,
    //this.exerciseRiR,
  });

  Future<List<Set>> getSetList(String exerciseId) async {
    List<Set> sets = [];

    final setResponse =
        await supabase.from('sets').select().eq('exercise_id', exerciseId);
    print(setResponse.toString());

    for (var map in setResponse) {
      sets.add(Set.fromMap(map));
    }
    return sets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Text(exercise.exerciseName.toString()),
        FutureBuilder<List<Set>>(
            future: getSetList(exercise.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        Text(snapshot.data![index].type));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
      ],
    ));
  }
}
