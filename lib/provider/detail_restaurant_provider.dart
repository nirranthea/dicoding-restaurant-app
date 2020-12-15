import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState {Loading, NoData, HasData, Error}

class DetailRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  final Resto resto;

  DetailRestaurantsProvider({@required this.apiService, @required this.resto}) {
    _fetchDetailRestaurant(resto);
  }

  DetailRestaurant _detailRestaurant;
  String _message = '';
  ResultState _state;

  String get message => _message;
  DetailRestaurant get result => _detailRestaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(Resto resto) async {
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
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}