class Foods {
  String name;

  Foods({this.name});

  factory Foods.fromJson(Map<String, dynamic> parsedJson) {
    return Foods(
      name: parsedJson['name'],
    );
  }

}