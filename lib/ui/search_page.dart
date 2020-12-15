import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';

import 'detail_page.dart';

class SearchPage extends StatelessWidget {

  static const routeName = '/search_page';

  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFcs = FocusNode();

  Widget _buildRestaurantItem(BuildContext context, Resto restaurant) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(ApiService.imageUrl + restaurant.pictureId, width: 100, fit: BoxFit.cover,)),
      title: Text(restaurant.name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 4),
          Row(
            children: <Widget>[
              Icon(Icons.location_on, size: 16, color: Colors.red,),
              SizedBox(width: 2),
              Text(restaurant.city,
                style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w300),),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Icon(Icons.star, size: 16, color: Colors.amber,),
              SizedBox(width: 2),
              Text('${restaurant.rating}',
                style: TextStyle(fontSize: 12, color: Colors.black),),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchRestaurantsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //NOTE: Header part
            Card(
              margin: EdgeInsets.all(0),
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/foods.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.white60.withOpacity(0.85),
                      elevation: 0,
                      iconTheme: IconThemeData(color: Colors.black),
                    ),
                    Container(
                      color: Colors.white60.withOpacity(0.85),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Search',
                              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 30,
                              child: TextFormField(
                                controller: _searchCtrl,
                                focusNode: _searchFcs,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                onFieldSubmitted: (value) {
                                  searchState.searchRestaurant(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //NOTE: Content part
            Expanded(
                child: Consumer<SearchRestaurantsProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.result.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant = state.result.restaurants[index];
                            return _buildRestaurantItem(context, restaurant);
                          });
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Container(width: 200, height:200, child: Image.asset('images/not_found.png', fit: BoxFit.contain)));
                    } else if (state.state == ResultState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  }
                )
            ),
          ],
        ),
      ),
    );
  }

}