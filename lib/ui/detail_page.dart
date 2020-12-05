import 'package:flutter/material.dart';
import '../data/model/drinks.dart';
import '../data/model/foods.dart';
import '../data/model/restaurant.dart';

class DetailPage extends StatelessWidget {

  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;
  const DetailPage({@required this.restaurant});

  @override
  Widget build(BuildContext context) {

    List<Foods>  foods  = restaurant.menu.foods;
    List<Drinks> drinks = restaurant.menu.drinks;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  '${restaurant.pictureId}',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text('${restaurant.name}'),
              centerTitle: true,
            ),
          ),
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
                      Text('${restaurant.city}'),
                    ],
                  ),
                  SizedBox(height: 32),
                  Text('${restaurant.description}',
                    style: Theme.of(context).textTheme.bodyText2,),
                  SizedBox(height: 32),
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
          SliverGrid.count(
            crossAxisCount: 2,
            children: foods.map((food) =>
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
          ),
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
          SliverGrid.count(
            crossAxisCount: 2,
            children: drinks.map((drink) =>
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
          ),
        ],
      ),
    );
  }
}