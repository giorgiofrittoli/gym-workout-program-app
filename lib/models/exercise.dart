class Exercise {
  final String id;
  final String name;
  final String description;
  final String imageURL;

  Exercise({this.id, this.name, this.description, this.imageURL});

  static Exercise parseEJson(Map<String, dynamic> data) {
    return Exercise(
      id: data["id"],
      name: data["name"],
      description: data["description"],
      imageURL: data["imageURL"],
    );
  }
}
