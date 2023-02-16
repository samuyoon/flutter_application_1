class Exercise {
  String id;
  String createdAt;
  String exerciseName;
  String exerciseType;
  num? exerciseSets;
  num? exerciseTargetReps;
  num? exerciseTargetLoad;
  num? exerciseTargetRir;
  num? exerciseActualReps;
  num? exerciseActualLoad;
  num? exerciseActualRir;
  String exerciseRest;
  String workoutId;

  Exercise(
    this.id,
    this.createdAt,
    this.exerciseName,
    this.exerciseType,
    this.exerciseSets,
    this.exerciseTargetReps,
    this.exerciseTargetLoad,
    this.exerciseTargetRir,
    this.exerciseActualReps,
    this.exerciseActualLoad,
    this.exerciseActualRir,
    this.exerciseRest,
    this.workoutId,
  );

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      map['id'] as String,
      map['created_at'] as String,
      map['exercise_name'] as String,
      map['exercise_type'] as String,
      map['exercise_sets'] as num,
      map['exercise_target_reps'] as num,
      map['exercise_target_load'] as num,
      map['exercise_target_rir'] as num,
      map['exercise_actual_reps'] as num,
      map['exercise_actual_load'] as num,
      map['exercise_actual_rir'] as num,
      map['exercise_rest'] as String,
      map['workout_id'] as String,
    );
  }
}
