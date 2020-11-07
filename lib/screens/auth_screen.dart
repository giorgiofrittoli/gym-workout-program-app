import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "../models/http_exception.dart";
import "../providers/auth_provider.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _authData = {
    "email": "",
    "password": "",
  };

  var _isLoading = false;
  var _validUsername = true;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    // if (!_formKey.currentState.validate()) {
    //   // Invalid!
    //   return;
    // }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<AuthProvider>(context, listen: false).auth(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      //_showErrorDialog(error.toString());
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _validUsername = false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: deviceSize.height,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'E-Mail',
                                errorText:
                                    _validUsername ? null : "Invalid username",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              validator: (value) {
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (_isLoading)
                              CircularProgressIndicator()
                            else
                              RaisedButton(
                                child: Text('LOGIN'),
                                onPressed: _submit,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 8.0),
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    .color,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
