import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

import 'detail_page.dart';

class FavouritePage extends StatelessWidget {

  static const routeName = '/favourite';

  Widget _buildRestaurantItem(BuildContext context, Resto restaurant, DetailRestaurantsProvider detailState) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
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
                detailState.fetchDetailRestaurant(restaurant);
                Navigation.intentWithData(DetailPage.routeName, restaurant);
              },
              trailing: isBookmarked
                  ? IconButton(
                icon: Icon(Icons.thumb_up),
                color: Colors.green,
                onPressed: () => provider.removeBookmark(restaurant.id),
              )
                  : IconButton(
                icon: Icon(Icons.thumb_up),
                color: Colors.grey,
                onPressed: () => provider.addBookmark(restaurant),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailState = Provider.of<DetailRestaurantsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //Note: Header part
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
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text('Favourite Restaurant',
                              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //NOTE: Content part
            Expanded(
                child: Consumer<DatabaseProvider>(
                    builder: (context, provider, child) {
                      if (provider.state == ResultState.HasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.bookmarks.length,
                            itemBuilder: (context, index) {
                              var restaurant = provider.bookmarks[index];
                              return _buildRestaurantItem(context, restaurant, detailState);
                            });
                      } else if (provider.state == ResultState.NoData) {
                        return Center(child: Text(provider.message));
                      } else if (provider.state == ResultState.Error) {
                        return Center(child: Text(provider.message));
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