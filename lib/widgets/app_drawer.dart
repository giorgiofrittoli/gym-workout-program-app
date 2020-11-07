import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/auth_provider.dart";

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer<AuthProvider>(
            builder: (_, auth, _c) => AppBar(
              title: Text("Hello ${auth.user.firstName}"),
              automaticallyImplyLeading: false,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed("/");
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
