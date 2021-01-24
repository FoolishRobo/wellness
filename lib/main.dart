import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness/view/home_page.dart';
import 'package:wellness/view_model/countries_list_vm.dart';
import 'package:wellness/view_model/favourite_vm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CountriesListVm()),
          ChangeNotifierProvider(create: (context) => FavouriteVm()),
        ],
        child: HomePage(),
      ),
    );
  }
}
