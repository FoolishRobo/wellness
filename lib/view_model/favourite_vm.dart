import 'package:flutter/cupertino.dart';
import 'package:wellness/model/countries_model.dart';
import 'package:wellness/services/database_helper.dart';

class FavouriteVm extends ChangeNotifier {
  bool isVmInitialized = false;

  List<Countries> countriesList;

  void init(BuildContext context) {
    if (isVmInitialized) return;

    isVmInitialized = true;

    fetchListFromDB();

    Future.delayed(Duration(milliseconds: 0), () {
      notifyListeners();
    });
  }

  Future<void> fetchListFromDB() async {
    countriesList = [];
    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      String rowId = "DZ";
      List<Countries> countries = await helper.queryAllCountries();
      if (countries != null) {
        countriesList = countries;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void addOrRemoveFavourite(Countries countries) {
    Countries foundElement;
    countriesList = countriesList ?? [];

    countriesList.forEach((element) {
      if (element.abbriviation == countries.abbriviation) {
        foundElement = element;
        remove(countries);
      }
    });

    if (foundElement != null) {
      countriesList.remove(foundElement);
      remove(foundElement);
      notifyListeners();
      return;
    }

    countriesList.add(countries);
    save(countries);
    notifyListeners();
  }

  bool contains(Countries countries) {
    bool isFound = false;
    countriesList.forEach((element) {
      if (element.abbriviation == countries.abbriviation) {
        isFound = true;
      }
    });
    return isFound;
  }

  save(Countries countries) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(countries);
    print('inserted row: $id');
  }

  remove(Countries countries) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.delete(countries);
    print('deleted row: $id');
  }
}
