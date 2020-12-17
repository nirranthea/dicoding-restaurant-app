import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import '../data/model/response.dart';

class HomePage extends StatelessWidget {

  static const routeName = '/home_page';

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
                child: Container(
                  color: Colors.white60.withOpacity(0.85),
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
                    title: Text('Restaurant',
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),
                    ),
                    subtitle: Text('Recommendation restaurant for you!',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.search),
                      iconSize: 24,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, SearchPage.routeName);
                      },
                    ),
                  ),
                ),
              ),
            ),
            //NOTE: Content part
            Expanded(
              child: Consumer<RestaurantsProvider>(
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
                    return Center(child: Text(state.message));
                  } else if (state.state == ResultState.Error) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}