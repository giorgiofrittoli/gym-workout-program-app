import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "../providers/auth_provider.dart";
import "../widgets/app_drawer.dart";

class UserProfileScreen extends StatefulWidget {
  static const routeName = "/user-profile";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _userData = {
    "username": "",
    "firstName": "",
    "lastName": "",
    "password": ""
  };

  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    _isLoading = true;

    try {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).updateUser(_userData);
      Navigator.of(context).pushReplacementNamed("/");
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final user = Provider.of<AuthProvider>(context, listen: false).user;
      _userData["username"] = user.username;
      _userData["firstName"] = user.firstName;
      _userData["lastName"] = user.lastName;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Profilo utente"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        height: deviceInfo.height,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Card(
                color: Colors.black38,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: Colors.white,
                            initialValue: _userData["username"],
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            style: Theme.of(context).textTheme.subtitle2,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) return "Inserire l'ursername";
                              return null;
                            },
                            onSaved: (value) {
                              _userData["username"] = value;
                            },
                          ),
                          TextFormField(
                            cursorColor: Colors.white,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            style: Theme.of(context).textTheme.subtitle2,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              _userData["password"] = value;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            cursorColor: Colors.white,
                            initialValue: _userData["firstName"],
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            style: Theme.of(context).textTheme.subtitle2,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) return "Inserire il nome";
                              return null;
                            },
                            onSaved: (value) {
                              _userData["firstName"] = value;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            cursorColor: Colors.white,
                            initialValue: _userData["lastName"],
                            decoration: InputDecoration(
                              labelText: 'Cognome',
                              labelStyle: Theme.of(context).textTheme.subtitle2,
                            ),
                            style: Theme.of(context).textTheme.subtitle2,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) return "Inserire il cognome";
                              return null;
                            },
                            onSaved: (value) {
                              _userData["lastName"] = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        backgroundColor: Colors.blue,
        child: Icon(Icons.save),
      ),
      drawer: AppDrawer(),
    );
  }
}
