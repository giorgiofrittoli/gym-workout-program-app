class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;

  User({this.id, this.username, this.firstName, this.lastName});

  static User parseUJSon(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData["id"],
      username: jsonData["username"],
      firstName: jsonData["firstName"],
      lastName: jsonData["lastName"],
    );
  }
}
