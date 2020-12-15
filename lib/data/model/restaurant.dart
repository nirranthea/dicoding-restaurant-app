import 'package:restaurant_app/data/model/customer_reviews.dart';

import 'menu.dart';

class DetailRestaurant {
  bool error;
  String message;
  Restaurant restaurant;

  DetailRestaurant({
    this.error, this.message, this.restaurant,
  });

  factory DetailRestaurant.fromJson(Map<String, dynamic> parsedJson) {
    var restaurantObj;
    if (parsedJson['restaurant'] != null) {
      restaurantObj = Restaurant.fromJson(parsedJson['restaurant']);
    }
    return DetailRestaurant(
      error: parsedJson['error'],
      message: parsedJson['message'],
      restaurant: restaurantObj,
    );
  }
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String address;
  String city;
  double rating;
  Menu menu;
  List<CustomerReviews> customerReviews;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.address,
    this.city,
    this.rating,
    this.menu,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    var menuObj;
    if (parsedJson['menus'] != null) {
      menuObj = Menu.fromJson(parsedJson['menus']);
    }
    var listReview = parsedJson['customerReviews'] as List;
    List<CustomerReviews> reviewList;
    if (listReview != null) {
      reviewList = listReview.map((i) => CustomerReviews.fromJson(i)).toList();
    }
    return Restaurant(
      id: parsedJson['id'],
      name: parsedJson['name'],
      description: parsedJson['description'],
      pictureId: parsedJson['pictureId'],
      address: parsedJson['address'],
      city: parsedJson['city'],
      rating: parsedJson['rating'].toDouble(),
      menu: menuObj,
      customerReviews: reviewList,
    );
  }
}