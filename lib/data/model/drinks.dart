class Drinks {
  String name;

  Drinks({this.name});

  factory Drinks.fromJson(Map<String, dynamic> parsedJson) {
    return Drinks(
      name: parsedJson['name'],
    );
  }
}