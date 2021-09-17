import '../models/workout_exercise.dart';

class WorkoutDay {
  final String id;
  final String title;
  final String description;
  final int order;
  final List<WorkoutExercise> lWorkoutExercise;
  bool active;

  WorkoutDay({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.lWorkoutExercise,
    this.active = false,
  });

  @override
  String toString() {
    return 'WorkoutDay{id: $id, title: $title, description: $description, order: $order, lWorkoutExercise: $lWorkoutExercise, active: $active}';
  }

  static WorkoutDay fromJson(Map<String, dynamic> data) {
    return WorkoutDay(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      order: int.parse(data["showOrder"]),
      lWorkoutExercise: (data["workoutExerciseList"] as List<dynamic>)
          .map((workoutExercise) => WorkoutExercise.fromJson(workoutExercise))
          .toList(),
    );
  }
}
