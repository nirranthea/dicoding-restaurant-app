import 'customer_reviews.dart';

class PostReview {
  bool error;
  String message;
  List<CustomerReviews> customerReviews;

  PostReview({this.error, this.message, this.customerReviews});

  factory PostReview.fromJson(Map<String, dynamic> parsedJson) {
    var listReview = parsedJson['customerReviews'] as List;
    List<CustomerReviews> reviewList;
    if (listReview != null) {
      reviewList = listReview.map((i) => CustomerReviews.fromJson(i)).toList();
    }
    return PostReview(
      error: parsedJson['error'],
      message: parsedJson['message'],
      customerReviews: reviewList,
    );
  }
}