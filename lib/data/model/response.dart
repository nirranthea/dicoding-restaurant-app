import 'dart:convert';

import 'restaurant.dart';

class Response {
  List<Restaurant> restaurants;
  Response({this.restaurants});

  factory Response.fromJson(Map<String, dynamic> parsedJson) {
    var listRestaurant  = parsedJson['restaurants'] as List;
    List<Restaurant> restaurantList;
    if (listRestaurant != null) {
      restaurantList  = listRestaurant.map((i) => Restaurant.fromJson(i)).toList();
    }
    return Response(
        restaurants: restaurantList,
    );
  }
}

Response parseLocal(var response) {
  dynamic jsonObject = json.decode(response);
  return Response.fromJson(jsonObject);
}







