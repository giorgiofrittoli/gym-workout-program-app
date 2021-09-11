import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./providers/auth_provider.dart";
import "./providers/workout_provider.dart";
import './screens/auth_screen.dart';
import "./screens/user_profile_screen.dart";
import "./screens/workout_day_screen.dart";
import './screens/workout_exercise_screen.dart';
import '../screens/dashboard_screen.dart';

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
          create: (ctx) => WorkoutProvider(null, null, null),
          update: (_, auth, prevWorkProvider) => WorkoutProvider(
            prevWorkProvider != null ? prevWorkProvider.workoutProgram : null,
            auth.authToken,
            auth.userId,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (_, auth, _c) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              //systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Color.fromRGBO(33, 33, 33, 1),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green,
            ),
            primaryIconTheme: IconThemeData(
              color: Colors.green,
            ),
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
            colorScheme: ColorScheme.dark().copyWith(
              primary: Color.fromRGBO(0, 0, 0, 1),
              secondary: Color.fromRGBO(33, 33, 33, 1),
            ),
          ),
          title: 'Gym workout program',
          home: auth.isAuth
              ? DashboardScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator())
                          : AuthScreen(),
                ),
          routes: {
            DashboardScreen.routeName: (_) => DashboardScreen(),
            WorkoutDayScreen.routeName: (_) => WorkoutDayScreen(),
            WorkoutExcerciseScreen.routeName: (_) => WorkoutExcerciseScreen(),
            UserProfileScreen.routeName: (_) => UserProfileScreen(),
          },
        ),
      ),
    );
  }
}
