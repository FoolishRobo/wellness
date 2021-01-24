import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness/model/countries_model.dart';
import 'package:wellness/services/service.dart';
import 'package:wellness/view_model/favourite_vm.dart';

class CountriesListVm extends ChangeNotifier {
  bool isVmInitialized = false;
  int limit = 10;
  int offset = 0;
  List<Countries> countriesList;

  void init(BuildContext context) async {
    if (isVmInitialized) return;

    isVmInitialized = false;

    await fetchCountryList(context);
    notifyListeners();
  }

  Future<void> fetchCountryList(BuildContext context) async {
    var queryParameters = {
      'limit': '$limit',
      'offset': '$offset',
    };
    String list1 = await Service().httpGet(
        "api.first.org", "/data/v1/countries", queryParameters, context);
    parseJsonToObject(list1);
    offset = offset + limit;
  }

  void addToFavourite(BuildContext context, Countries countries) {
    FavouriteVm _vm = Provider.of<FavouriteVm>(context, listen: false);
    _vm.addOrRemoveFavourite(countries);
  }

  void parseJsonToObject(String body) {
    List<Countries> list = [];
    Map userMap = jsonDecode(body);
    userMap["data"].forEach((key, dynamic value) {
      Countries _countries = Countries(
          abbriviation: key,
          countryDetail:
              Country(country: value['country'], region: value['region']));
      list.add(_countries);
    });
    countriesList = countriesList ?? [];
    countriesList.addAll(list);
    notifyListeners();
  }
}
