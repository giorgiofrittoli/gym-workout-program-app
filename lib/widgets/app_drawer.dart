import "package:flutter/material.dart";
import 'package:gym_workout_program/screens/workout_program_list.dart';
import "package:provider/provider.dart";

import "../providers/auth_provider.dart";
import '../screens/dashboard_screen.dart';
import '../screens/exercise_list_screen.dart';
import "../screens/user_profile_screen.dart";

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Consumer<AuthProvider>(
              builder: (_, auth, _c) => AppBar(
                title: Text("Hello ${auth.user!.firstName}"),
                automaticallyImplyLeading: false,
              ),
            ),
            Divider(
              height: 20,
            ),
            AppDrawerItem(
              icon: Icons.folder_shared_sharp,
              title: "Dashboard",
              route: DashboardScreen.routeName,
            ),
            Divider(color: Colors.white, thickness: 0.5),
            AppDrawerItem(
              icon: Icons.person,
              title: "Profilo utente",
              route: UserProfileScreen.routeName,
            ),
            Divider(color: Colors.white, thickness: 0.5),
            AppDrawerItem(
              icon: Icons.view_list,
              title: "Archivio schede",
              route: WorkoutProgramsScreen.routeName,
            ),
            Divider(color: Colors.white, thickness: 0.5),
            AppDrawerItem(
              icon: Icons.view_list,
              title: "Esercizi",
              route: ExerciseListScreen.routeName,
            ),
            Divider(color: Colors.white, thickness: 0.5),
            AppDrawerItem(
              icon: Icons.exit_to_app,
              title: "Logout",
              action: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed("/");
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? route;
  final Function? action;

  AppDrawerItem({
    required this.icon,
    required this.title,
    this.route,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () {
        if (action != null) {
          action!();
        }
        if (route != null) {
          Navigator.of(context).pushReplacementNamed(route!);
        }
      },
    );
  }
}
