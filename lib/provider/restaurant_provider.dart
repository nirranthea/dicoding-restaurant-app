import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({@required this.apiService}) {
    _fetchAllRestaurant();
  }

  RestaurantResult _restaurantsResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantResult get result => _restaurantsResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getListRestaurants();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Periksa Koneksi Internet Anda!';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}