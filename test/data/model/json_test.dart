import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/post_review.dart';
import 'package:restaurant_app/data/model/response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  group('Parsing JSON Test', () {
    //NOTE: RestaurantResult
    test('parsing json to class RestaurantResult', () {
      //arrange
      var restaurantResult = RestaurantResult();
      var testResultJson = {
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      };

      //act
      restaurantResult = RestaurantResult.fromJson(testResultJson);

      //assert
      expect(restaurantResult.restaurants.length, 2);
      expect(restaurantResult.restaurants[0].id, "rqdv5juczeskfw1e867");
      expect(restaurantResult.restaurants[1].id, "s1knt6za9kkfw1e867");
      expect(restaurantResult.restaurants[0].name, "Melting Pot");
      expect(restaurantResult.restaurants[1].name, "Kafe Kita");
      expect(restaurantResult.restaurants[0].description, "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...");
      expect(restaurantResult.restaurants[1].description, "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...");
      expect(restaurantResult.restaurants[0].pictureId, "14");
      expect(restaurantResult.restaurants[1].pictureId, "25");
      expect(restaurantResult.restaurants[0].city, "Medan");
      expect(restaurantResult.restaurants[1].city, "Gorontalo");
      expect(restaurantResult.restaurants[0].rating, 4.2);
      expect(restaurantResult.restaurants[1].rating, 4);
    });

    //NOTE: DetailRestaurant
    test('parsing json to class DetailRestaurant', () {
      //arrange
      var detRestaurant = DetailRestaurant();
      var testRestoJson = {
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "menus": {
            "foods": [
              {
                "name": "Paket rosemary"
              },
              {
                "name": "Toastie salmon"
              }
            ],
            "drinks": [
              {
                "name": "Es krim"
              },
              {
                "name": "Sirup"
              }
            ]
          },
          "rating": 4.2,
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            }
          ]
        }
      };

      //act
      detRestaurant = DetailRestaurant.fromJson(testRestoJson);

      //assert
      expect(detRestaurant.error, false);
      expect(detRestaurant.message, "success");
      expect(detRestaurant.restaurant.id, "rqdv5juczeskfw1e867");
      expect(detRestaurant.restaurant.name, "Melting Pot");
      expect(detRestaurant.restaurant.description, "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...");
      expect(detRestaurant.restaurant.city, "Medan");
      expect(detRestaurant.restaurant.address, "Jln. Pandeglang no 19");
      expect(detRestaurant.restaurant.pictureId, "14");
      expect(detRestaurant.restaurant.rating, 4.2);
      expect(detRestaurant.restaurant.menu.foods.length, 2);
      expect(detRestaurant.restaurant.menu.drinks.length, 2);
      expect(detRestaurant.restaurant.customerReviews[0].name, "Ahmad");
    });

    //NOTE: PostReview
    test('parsing json to class PostReview', () {
      //arrange
      var postReview = PostReview();
      var testReviewJson = {
        "error": false,
        "message": "success",
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          },
          {
            "name": "test",
            "review": "makanannya lezat",
            "date": "29 Oktober 2020"
          }
        ]
      };
      
      //act
      postReview = PostReview.fromJson(testReviewJson);
      
      //assert
      expect(postReview.error, false);
      expect(postReview.message, "success");
      expect(postReview.customerReviews.length, 2);
      expect(postReview.customerReviews[0].name, "Ahmad");
      expect(postReview.customerReviews[1].name, "test");
      expect(postReview.customerReviews[0].review, "Tidak rekomendasi untuk pelajar!");
      expect(postReview.customerReviews[1].review, "makanannya lezat");
      expect(postReview.customerReviews[0].date, "13 November 2019");
      expect(postReview.customerReviews[1].date, "29 Oktober 2020");
    });
  });

  group('Convert into JSON Test', () {
    test('convert to json from class RestaurantResult', () {
      //arrange
      var testResultJson = {
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      };
      var testRestaurantResult = RestaurantResult(
        restaurants: [
          Resto(id: "rqdv5juczeskfw1e867", name: "Melting Pot",
            description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            pictureId: "14", city: "Medan", rating: 4.2),
          Resto(id: "s1knt6za9kkfw1e867", name: "Kafe Kita",
              description: "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
              pictureId: "25", city: "Gorontalo", rating: 4),
        ],
      );
      var resultJson;

      //act
      resultJson = testRestaurantResult.toJson();

      //assert
      expect(resultJson, testResultJson);

    });
  });

}