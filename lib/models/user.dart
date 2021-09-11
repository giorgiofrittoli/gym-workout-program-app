class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  static User parseUJSon(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData["id"],
      username: jsonData["username"],
      firstName: jsonData["firstName"],
      lastName: jsonData["lastName"],
    );
  }
}
