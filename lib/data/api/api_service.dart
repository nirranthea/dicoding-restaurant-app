import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/post_review.dart';
import 'package:restaurant_app/data/model/response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium/';

  Future<RestaurantResult> getListRestaurants() async {
    final response = await http.get(_baseUrl + "list");
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String idRestaurant) async {
    final response = await http.get(_baseUrl + "detail/" +idRestaurant);
    if (response.statusCode == 200) {
      print(response.body);
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantResult> searchRestaurant(String query) async {
    final response = await http.get(_baseUrl + "search?q=" +query);
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<PostReview> postReview(String id, String name, String review) async {
    final body = {
      'id': id,
      'name': name,
      'review': review,
    };
    final response = await http.post(_baseUrl + "review",
      headers: {'Content-Type': 'application/json', 'X-Auth-Token': '123456'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return PostReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}