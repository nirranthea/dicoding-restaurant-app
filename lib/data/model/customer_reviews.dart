class CustomerReviews {
  String name;
  String review;
  String date;

  CustomerReviews({this.name, this.review, this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> parsedJson) {
    return CustomerReviews(
      name: parsedJson['name'],
      review: parsedJson['review'],
      date: parsedJson['date'],
    );
  }
}