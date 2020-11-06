import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./providers/auth_provider.dart";
import "./providers/workout_provider.dart";
import './screens/auth_screen.dart';
import "./screens/workout_day_screen.dart";
import './screens/workout_exercise_screen.dart';
import './screens/workout_program_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, WorkoutProvider>(
          create: null,
          update: (_, auth, prevWorkProvider) => WorkoutProvider(
            prevWorkProvider != null ? prevWorkProvider.workoutProgram : null,
            auth.authToken,
            auth.userId,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (_, auth, _c) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                  fontSize: 16,
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          title: 'Gym workout program',
          home: auth.isAuth ? WorkoutProgramScreen() : AuthScreen(),
          routes: {
            WorkoutDayScreen.routeName: (_) => WorkoutDayScreen(),
            WorkoutExcerciseScreen.routeName: (_) => WorkoutExcerciseScreen(),
          },
        ),
      ),
    );
  }
}
