import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class DetailRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantsProvider({@required this.apiService});

  DetailRestaurant _detailRestaurant;
  String _message = '';
  ResultState _state;

  String get message => _message;
  DetailRestaurant get result => _detailRestaurant;
  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(Resto resto) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getDetailRestaurant(resto.id);
      if (restaurants.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurant = restaurants;
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