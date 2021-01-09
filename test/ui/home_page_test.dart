import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/home_page.dart';

Widget createHomeScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantsProvider>(
          create: (context) => RestaurantsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DetailRestaurantsProvider>(
          create: (context) => DetailRestaurantsProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );


void main() {
  testWidgets('Testing if IconButton show up', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());
    expect(find.byType(IconButton), findsNWidgets(3));
  });
}