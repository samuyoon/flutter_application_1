class Workout {
  String id;
  String createdAt;
  String workoutName;
  bool workoutCompleted;

  Workout(this.id, this.createdAt, this.workoutName, this.workoutCompleted);

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      map['id'] as String,
      map['created_at'] as String,
      map['workout_name'] as String,
      map['workout_completed'] as bool,
    );
  }
}
