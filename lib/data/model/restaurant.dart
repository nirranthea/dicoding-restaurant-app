import 'menu.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menu menu;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menu,
  });

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    var menuObj;
    if (parsedJson['menus'] != null) {
      menuObj = Menu.fromJson(parsedJson['menus']);
    }
    return Restaurant(
      id: parsedJson['id'],
      name: parsedJson['name'],
      description: parsedJson['description'],
      pictureId: parsedJson['pictureId'],
      city: parsedJson['city'],
      rating: parsedJson['rating'],
      menu: menuObj,
    );
  }
}