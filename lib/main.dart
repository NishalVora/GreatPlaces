import 'package:Great_Places/providers/great_places.dart';
import 'package:Great_Places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'screens/place_list_screen.dart';
import 'package:provider/provider.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
