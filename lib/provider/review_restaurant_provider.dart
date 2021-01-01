import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/post_review.dart';
import 'package:restaurant_app/data/model/response.dart';

class ReviewRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final Resto resto;

  ReviewRestaurantProvider({@required this.apiService, @required this.resto});

  PostReview _postReview;
  String _message = '';
  ResultState _state;

  String get message => _message;
  PostReview get result => _postReview;
  ResultState get state => _state;

  Future<dynamic> postReviewRestaurant(Resto resto, String name, String review) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final reviews = await apiService.postReview(resto.id, name, review);
      if (reviews.customerReviews == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _postReview = reviews;
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