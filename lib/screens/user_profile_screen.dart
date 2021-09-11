import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "../providers/auth_provider.dart";
import "../widgets/app_drawer.dart";
import "../widgets/input_text.dart";

class UserProfileScreen extends StatefulWidget {
  static const routeName = "/user-profile";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _userData = {
    "username": "",
    "firstName": "",
    "lastName": "",
    "password": ""
  };

  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: 2,
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final user = Provider.of<AuthProvider>(context, listen: false).user!;
      _userData["username"] = user.username;
      _userData["firstName"] = user.firstName;
      _userData["lastName"] = user.lastName;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _saveInput(field, value) {
    _userData[field] = value;
  }

  String? _validateUsername(String value) {
    if (value.isEmpty) {
      _tabController!.animateTo(0);
      return "Inserire l'username";
    }
    return null;
  }

  String? _validateFirstName(String value) {
    if (value.isEmpty) {
      _tabController!.animateTo(1);
      return "Inserire il nome";
    }
    return null;
  }

  String? _validateLastName(String value) {
    if (value.isEmpty) {
      _tabController!.animateTo(1);
      return "Inserire il cognome";
    }
    return null;
  }

  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilo utente"),
      ),
      bottomNavigationBar: TabBar(
        indicatorColor: Colors.green,
        controller: _tabController,
        tabs: [
          Tab(
            text: "Utente",
          ),
          Tab(
            text: "Persona",
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        height: deviceInfo.height,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Card(
                child: Form(
                  key: _formKey,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              InputText(
                                field: "username",
                                title: "Username",
                                validator: _validateUsername,
                                initValue: _userData["username"],
                                savedInput: _saveInput,
                              ),
                              SizedBox(height: 30),
                              InputText(
                                field: "password",
                                title: "Password",
                                initValue: "",
                                validator: null,
                                savedInput: _saveInput,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              InputText(
                                field: "firstName",
                                title: "Nome",
                                initValue: _userData["firstName"],
                                validator: _validateFirstName,
                                savedInput: _saveInput,
                              ),
                              SizedBox(height: 30),
                              InputText(
                                field: "lastName",
                                title: "Cognome",
                                initValue: _userData["lastName"],
                                validator: _validateLastName,
                                savedInput: _saveInput,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        child: Icon(Icons.save),
      ),
      drawer: AppDrawer(),
    );
  }
}
