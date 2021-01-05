import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {

  static const routeName = '/setting_page';

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
                          title: Text('Setting',
                            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black)),
                          leading: Icon(Icons.settings),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //NOTE: Content part
            Expanded(
              child: Consumer<PreferencesProvider>(
                builder: (context, provider, child) {
                  return ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('Restaurant Notification'),
                        trailing: Consumer<SchedulingProvider>(
                          builder: (context, scheduled, _) {
                            return Switch.adaptive(
                              value: provider.isDailyRestaurantActive,
                              onChanged: (value) async {
                                scheduled.scheduledResto(value);
                                provider.enableDailyRestaurant(value);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}