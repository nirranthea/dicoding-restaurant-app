import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/review_restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/ui/splash_page.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'ui/detail_page.dart';
import 'ui/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: navigatorKey,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        HomePage.routeName: (context) => ChangeNotifierProvider<RestaurantsProvider>(
            create: (_) => RestaurantsProvider(apiService: ApiService()),
            child: HomePage()),
        SearchPage.routeName: (context) => ChangeNotifierProvider<SearchRestaurantsProvider>(
            create: (_) => SearchRestaurantsProvider(apiService: ApiService()),
            child: SearchPage()),
        DetailPage.routeName: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider<DetailRestaurantsProvider>(
                  create: (_) => DetailRestaurantsProvider(
                      apiService: ApiService(),
                      resto: ModalRoute.of(context).settings.arguments),
                ),
                ChangeNotifierProvider<ReviewRestaurantProvider>(
                  create: (_) => ReviewRestaurantProvider(
                    apiService: ApiService(),
                    resto: ModalRoute.of(context).settings.arguments),
                )
              ],
              child: DetailPage(
                restaurant: ModalRoute.of(context).settings.arguments,
              ),
            ),
        SettingPage.routeName: (context) => ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider(),
            child: SettingPage()),
      },
    );
  }
}

