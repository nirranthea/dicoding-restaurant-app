import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import '../data/model/response.dart';
import '../data/model/restaurant.dart';

class HomePage extends StatelessWidget {

  static const routeName = '/home_page';

  Future<String> _loadAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json');
  }

  Future<List<Restaurant>> _loadRestaurants(BuildContext context) async {
    String jsonString = await _loadAsset(context);
    return parseLocal(jsonString).restaurants;
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(restaurant.pictureId, width: 100, fit: BoxFit.cover,)),
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
                  ),
                ),
              ),
            ),
            //NOTE: Content part
            Expanded(
              child: FutureBuilder<List<Restaurant>>(
                future: _loadRestaurants(context),
                builder: (context, snapshot) {
                  List<Restaurant> restaurants = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return _buildRestaurantItem(context, restaurants[index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Load Data Error. Please Restart App'),);
                  } else {
                    return Center(child: CircularProgressIndicator());
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