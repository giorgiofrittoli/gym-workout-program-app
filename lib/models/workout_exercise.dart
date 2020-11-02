import 'exercise.dart';

class WorkoutExercise {
  final String id;
  final Exercise exercise;
  final String reps;
  final String pause;
  final String notes;
  bool active;

  WorkoutExercise(
      {this.id,
      this.exercise,
      this.reps,
      this.notes,
      this.pause,
      this.active = false});

  static WorkoutExercise parseWEJson(Map<String, dynamic> data) {
    return WorkoutExercise(
      id: data["id"],
      reps: data["reps"],
      pause: data["pause"],
      exercise: Exercise.parseEJson(
        data["exercise"],
      ),
    );
  }
}
