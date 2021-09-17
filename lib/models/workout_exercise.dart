import 'exercise.dart';

class WorkoutExercise {
  final String id;
  final Exercise exercise;
  final String reps;
  final String pause;
  final String? notes;
  bool active;

  WorkoutExercise({
    required this.id,
    required this.exercise,
    required this.reps,
    this.notes,
    required this.pause,
    this.active = false,
  });

  @override
  String toString() {
    return 'WorkoutExercise{id: $id, exercise: $exercise, reps: $reps, pause: $pause, notes: $notes, active: $active}';
  }

  static WorkoutExercise fromJson(Map<String, dynamic> data) {
    return WorkoutExercise(
      id: data["id"],
      reps: data["reps"],
      pause: data["pause"],
      exercise: Exercise.fromJson(
        data["exercise"],
      ),
    );
  }
}
