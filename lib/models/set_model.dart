class Set {
  String id;
  String createdAt;
  String type;
  num? targetReps;
  num? targetLoad;
  num? targetRir;
  num? actualReps;
  num? actualLoad;
  num? actualRir;
  String exerciseId;

  Set(
    this.id,
    this.createdAt,
    this.type,
    this.targetReps,
    this.targetLoad,
    this.targetRir,
    this.actualReps,
    this.actualLoad,
    this.actualRir,
    this.exerciseId,
  );

  factory Set.fromMap(Map<String, dynamic> map) {
    return Set(
      map['id'] as String,
      map['created_at'] as String,
      map['type'] as String,
      map['target_reps'] as num,
      map['target_load'] as num,
      map['target_rir'] as num,
      map['actual_reps'] as num,
      map['actual_load'] as num,
      map['actual_rir'] as num,
      map['exercise_id'] as String,
    );
  }
}
