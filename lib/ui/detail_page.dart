import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/customer_reviews.dart';
import 'package:restaurant_app/data/model/response.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/review_restaurant_provider.dart';

class DetailPage extends StatelessWidget {

  static const routeName = '/restaurant_detail';

  final Resto restaurant;
  DetailPage({@required this.restaurant});

  final _nameCtrl   = TextEditingController();
  final _reviewCtrl = TextEditingController();
  final _nameFcs    = FocusNode();
  final _reviewFcs  = FocusNode();
  final _scaffoldKey   = GlobalKey<ScaffoldState>();

  _submitReview(ReviewRestaurantProvider state,
      Resto resto, String name, String review) {
    state.postReviewRestaurant(resto, name, review);
  }

  _buildReview(BuildContext context, CustomerReviews review) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      leading: Icon(Icons.comment),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(review.date, style: Theme.of(context).textTheme.caption),
          SizedBox(height: 4),
          Text(review.name, style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
      subtitle: Text(review.review),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewState = Provider.of<ReviewRestaurantProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          //NOTE: Header part
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  '${ApiService.imageUrl + restaurant.pictureId}',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text('${restaurant.name}'),
              centerTitle: true,
            ),
          ),
          //NOTE: Detail part
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 24),
                  Text('${restaurant.name}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Icon(Icons.place, size: 16, color: Colors.red,),
                      SizedBox(width: 4),
                      Consumer<DetailRestaurantsProvider>(
                        builder: (context, state, _) {
                          if (state.state == ResultState.Loading) {
                            return CircularProgressIndicator();
                          } else if (state.state == ResultState.HasData) {
                            return Text('${state.result.restaurant.address}, ${restaurant.city}');
                          } else if (state.state == ResultState.NoData) {
                            return Text('Unknown');
                          } else if (state.state == ResultState.Error) {
                            return Text(state.message);
                          } else {
                            return Text('');
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, size: 16, color: Colors.amber,),
                      SizedBox(width: 4),
                      Text('${restaurant.rating} / 5.0',
                        style: TextStyle(fontSize: 12, color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 32),
                  Text('${restaurant.description}',
                    style: Theme.of(context).textTheme.bodyText2,),
                  SizedBox(height: 32),
                  //NOTE: Tag menu foods
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Colors.green,
                        ),
                        child: Text('Makanan',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                      Expanded(child: Divider(height: 0, thickness: 0.5, color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //NOTE: Menu foods
          Consumer<DetailRestaurantsProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              } else if (state.state == ResultState.HasData) {
                return SliverGrid.count(
                  crossAxisCount: 2,
                  children: state.result.restaurant.menu.foods.map((food) =>
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/placeholder_food.jpg'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(food.name,
                              style: TextStyle(fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                  ).toList(),
                );
              } else if (state.state == ResultState.NoData) {
                return SliverToBoxAdapter(child: Center(child: Text(state.message)));
              } else if (state.state == ResultState.Error) {
                return SliverToBoxAdapter(child: Center(child: Text(state.message)));
              } else {
                return SliverToBoxAdapter(child: Center(child: Text('')));
              }
            },
          ),
          //NOTE: Tag menu drinks
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Colors.green,
                        ),
                        child: Text('Minuman',
                            style: TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                      Expanded(child: Divider(height: 0, thickness: 0.5, color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //NOTE: Menu drinks
          Consumer<DetailRestaurantsProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              } else if (state.state == ResultState.HasData) {
                return SliverGrid.count(
                  crossAxisCount: 2,
                  children: state.result.restaurant.menu.drinks.map((drink) =>
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/placeholder_drink.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(drink.name,
                              style: TextStyle(fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                  ).toList(),
                );
              } else if (state.state == ResultState.NoData) {
                return SliverToBoxAdapter(child: Center(child: Text(state.message)));
              } else if (state.state == ResultState.Error) {
                return SliverToBoxAdapter(child: Center(child: Text(state.message)));
              } else {
                return SliverToBoxAdapter(child: Center(child: Text('')));
              }
            },
          ),
          //NOTE: Tag review
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Colors.green,
                        ),
                        child: Text('Review Pelanggan',
                            style: TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                      Expanded(child: Divider(height: 0, thickness: 0.5, color: Colors.green)),
                    ],
                  ),
                  //NOTE: Review
                  Consumer2<DetailRestaurantsProvider, ReviewRestaurantProvider>(
                    builder: (context, stateDetail, stateReview, _) {
//                        if (stateDetail.state == ResultState.Loading) {
//                          return Center(child: CircularProgressIndicator());
//                        } else if (stateDetail.state == ResultState.HasData) {
//                          return ListView.separated(
//                              padding: EdgeInsets.symmetric(vertical: 16.0),
//                              physics: NeverScrollableScrollPhysics(),
//                              shrinkWrap: true,
//                              itemCount: stateDetail.result.restaurant.customerReviews.length,
//                              separatorBuilder: (context, index) {
//                                return Padding(
//                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                  child: Divider(
//                                      color: Colors.grey[300],
//                                      thickness: 1,
//                                      height: 0),
//                                );
//                              },
//                              itemBuilder: (context, index) {
//                                var review = stateDetail.result.restaurant.customerReviews[index];
//                                return _buildReview(context, review);
//                              });
//                        } else if (stateDetail.state == ResultState.NoData) {
//                          return Center(child: Text(stateDetail.message));
//                        } else if (stateDetail.state == ResultState.Error) {
//                          return Center(child: Text(stateDetail.message));
//                        } else {
//                          return Center(child: Text(''));
//                        }
                      if (stateReview.state == ResultState.Loading || stateDetail.state == ResultState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (stateReview.state == ResultState.HasData) {
                        return ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: stateReview.result.customerReviews.length,
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                    height: 0),
                              );
                            },
                            itemBuilder: (context, index) {
                              var review = stateReview.result.customerReviews[index];
                              return _buildReview(context, review);
                            });
                      } else if (stateDetail.state == ResultState.HasData) {
                        return ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: stateDetail.result.restaurant.customerReviews.length,
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                    height: 0),
                              );
                            },
                            itemBuilder: (context, index) {
                              var review = stateDetail.result.restaurant.customerReviews[index];
                              return _buildReview(context, review);
                            });
                      } else if (stateReview.state == ResultState.NoData) {
                        return Center(child: Text(stateReview.message));
                      } else if (stateDetail.state == ResultState.NoData) {
                        return Center(child: Text(stateDetail.message));
                      } else if (stateReview.state == ResultState.Error) {
                        return Center(child: Text(stateReview.message));
                      } else if (stateDetail.state == ResultState.Error) {
                        return Center(child: Text(stateDetail.message));
                      } else {
                        return Center(child: Text(''));
                      }
                    },
                  ),
                  //NOTE: Add Review
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Tuliskan review Anda', style: TextStyle(
                          fontSize: 16,
                        )),
                        TextFormField(
                          focusNode: _nameFcs,
                          controller: _nameCtrl,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            counterText: '',
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(_reviewFcs);
                          },
                        ),
                        TextFormField(
                          focusNode: _reviewFcs,
                          controller: _reviewCtrl,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          maxLines: null,
                          maxLength: 100,
                          decoration: InputDecoration(
                            labelText: 'Review',
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RaisedButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text('Kirim'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _submitReview(
                                reviewState,
                                restaurant,
                                _nameCtrl.text,
                                _reviewCtrl.text,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}