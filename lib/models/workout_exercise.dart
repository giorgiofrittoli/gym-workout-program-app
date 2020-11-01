import 'exercise.dart';

class WorkoutExercise {
  final String id;
  final Exercise exercise;
  final String reps;
  final String pause;
  final String notes;
  bool active;

  WorkoutExercise({this.id, this.exercise, this.reps, this.notes, this.pause, this.active = false});
}
