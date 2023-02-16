abstract class SupabaseTable {
  const SupabaseTable();
  String get tableName;
}

class WorkoutSupabaseTable implements SupabaseTable {
  const WorkoutSupabaseTable();

  @override
  String get tableName => "workouts";

  String get idColumn => "id";
  String get idCreatedAt => "created_at";
  String get idWorkoutName => "workout_name";
}
