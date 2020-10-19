import 'package:gym_workout_program/models/exercise.dart';
import 'package:gym_workout_program/models/workout_exercise.dart';

import 'models/user.dart';
import 'models/workout_day.dart';
import 'models/workout_program.dart';

final user = User(
  id: "1",
  firstName: "Giorgio",
  lastName: "Frittoli",
);

final ex1 = Exercize(
  id: "1",
  title: "Esercizio 1",
  description: "Descrizione esercizio 1\nDescrizione esercizio 1\nDescrizione esercizio 1\nDescrizione esercizio 1Descrizione esercizio 1Descrizione esercizio o 1Descrizione esercizio o 1Descrizione esercizio 1\n",
  imageURL: "https://i.ytimg.com/vi/5F8iPHvVq6E/maxresdefault.jpg",
);

final workoutProgram = WorkoutProgram(
  id: "1",
  start: DateTime.now(),
  duration: 5,
  durationType: DurationType.WEEKS,
  user: user,
  workoutDays: [
    WorkoutDay(
      id: "1",
      title: "Parte A",
      description: "Petto-Tricipiti-Schiena",
      order: 1,
      lWorkoutExercise: [
        WorkoutExercise(
          id: "1",
          exercise: ex1,
          description: "dasdsadsadsad",
          notes: "",
        ),
        WorkoutExercise(
          id: "2",
          exercise: ex1,
          description: "dasdsadsadsad",
          notes: "",
        ),
        WorkoutExercise(
          id: "1",
          exercise: ex1,
          description: "dasdsadsadsad",
          notes: "",
        ),
        WorkoutExercise(
          id: "2",
          exercise: ex1,
          description: "dasdsadsadsad",
          notes: "",
        ),
      ],
    ),
    WorkoutDay(
      id: "2",
      title: "Parte B",
      description: "Gambe-Spalle-Bicipiti",
      order: 2,
      lWorkoutExercise: [
        WorkoutExercise(
          id: "1",
          exercise: ex1,
          description: "dasdsadsadsad",
          notes: "",
        ),
        WorkoutExercise(
          id: "2",
          exercise: ex1,
          description: "dasdsadsadsad",
          notes: "",
        )
      ],
    )
  ],
);
