import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/auth_provider.dart";
import "../screens/user_profile_screen.dart";
import "../screens/workout_program_screen.dart";

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Consumer<AuthProvider>(
              builder: (_, auth, _c) => AppBar(
                title: Text("Hello ${auth.user.firstName}"),
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.folder_shared_sharp),
              title: Text(
                "Scheda",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(WorkoutProgramScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Profilo utente",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
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
