class Exercise {
  final String id;
  final String name;
  final String description;
  final String? imageURL;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.imageURL,
  });

  @override
  String toString() {
    return 'Exercise{id: $id, name: $name, description: $description, imageURL: $imageURL}';
  }

  static Exercise fromJson(Map<String, dynamic> data) {
    return Exercise(
      id: data["id"],
      name: data["name"],
      description: data["description"],
      imageURL: data["imageURL"],
    );
  }

  static List<Exercise> fromJsonList(List<dynamic> data) {
    return data.map((e) => fromJson(e)).toList();
  }
}
