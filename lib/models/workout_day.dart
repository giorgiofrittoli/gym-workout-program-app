import 'package:gym_workout_program/models/workout_exercise.dart';

class WorkoutDay {
  final String id;
  final String title;
  final String description;
  final int order;
  final List<WorkoutExercise> lWorkoutExercise;
  bool active;

  WorkoutDay({
    this.id,
    this.title,
    this.description,
    this.order,
    this.lWorkoutExercise,
    this.active = false,
  });

  static WorkoutDay parseWDJson(Map<String, dynamic> data) {
    return WorkoutDay(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      order: int.parse(data["showOrder"]),
      lWorkoutExercise: (data["workoutExerciseList"] as List<dynamic>)
          .map(
            (workoutExercise) => WorkoutExercise.parseWEJson(workoutExercise),
          )
          .toList(),
    );
  }
}
