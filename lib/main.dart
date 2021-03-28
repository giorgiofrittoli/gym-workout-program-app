import 'package:flutter/material.dart';
import 'package:gym_workout_program/models/workout_program.dart';
import "package:provider/provider.dart";

import "./providers/auth_provider.dart";
import "./providers/workout_provider.dart";
import './screens/auth_screen.dart';
import "./screens/user_profile_screen.dart";
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
            primaryColorDark: Color.fromRGBO(3, 3, 3, 1),
            accentColor: Color.fromRGBO(33, 33, 33, 1),
            primaryIconTheme: IconThemeData(color: Color.fromRGBO(170, 170, 170, 1)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: ThemeData.dark().textTheme.copyWith(
                subtitle1: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                subtitle2: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
          title: 'Gym workout program',
          home: auth.isAuth
              ? WorkoutProgramScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator())
                          : AuthScreen(),
                ),
          routes: {
            WorkoutProgramScreen.routeName: (_) => WorkoutProgramScreen(),
            WorkoutDayScreen.routeName: (_) => WorkoutDayScreen(),
            WorkoutExcerciseScreen.routeName: (_) => WorkoutExcerciseScreen(),
            UserProfileScreen.routeName: (_) => UserProfileScreen(),
          },
        ),
      ),
    );
  }
}
