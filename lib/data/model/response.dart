class RestaurantResult {
  List<Resto> restaurants;

  RestaurantResult({this.restaurants});

  factory RestaurantResult.fromJson(Map<String, dynamic> parsedJson) {
    var listRestaurant  = parsedJson['restaurants'] as List;
    List<Resto> restaurantList;
    if (listRestaurant != null) {
      restaurantList  = listRestaurant.map((i) => Resto.fromJson(i)).toList();
    }
    return RestaurantResult(
      restaurants: restaurantList,
    );
  }
}

class Resto {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Resto({this.id, this.name, this.description, this.pictureId, this.city,
  this.rating});

  factory Resto.fromJson(Map<String, dynamic> parsedJson) {
    return Resto(
      id: parsedJson['id'],
      name: parsedJson['name'],
      description: parsedJson['description'],
      pictureId: parsedJson['pictureId'],
      city: parsedJson['city'],
      rating: parsedJson['rating'].toDouble(),
    );
  }
}




