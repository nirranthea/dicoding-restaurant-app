import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response.dart';

enum ResultState {Loading, NoData, HasData, Error}

class SearchRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
//  final String query;

  SearchRestaurantsProvider({@required this.apiService, }) {
//    _searchRestaurant(query);
  }

  RestaurantResult _restaurantsResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  RestaurantResult get result => _restaurantsResult;
  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.searchRestaurant(query);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}