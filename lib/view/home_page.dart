import 'package:flutter/material.dart';
import 'package:wellness/constants/app_colors.dart';
import 'package:wellness/view/countries_list_view.dart';
import 'package:wellness/view/favourite_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pageIndex == 0
            ? AppColors.countryColorSelected
            : AppColors.favouriteColorSelected,
        leading: pageIndex == 0 ? Icon(Icons.home) : Icon(Icons.favorite),
        title: pageIndex == 0 ? Text("Countries") : Text("Favourite"),
      ),
      body: SafeArea(
          child: PageView.builder(
        controller: _pageController,
        itemCount: 2,
        itemBuilder: (context, index) => getAppPages(context, index),
      )),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              pageIndex = index;
            });
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
          currentIndex: pageIndex,
          elevation: 12.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: pageIndex == 0
                      ? AppColors.countryColorSelected
                      : AppColors.countryColorNotSeleceted,
                ),
                label: "Countried"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: pageIndex == 1
                      ? AppColors.favouriteColorSelected
                      : AppColors.favouriteColorNotSeleceted,
                ),
                label: "Favourite"),
          ]),
    );
  }

  Widget getAppPages(context, index) {
    if (index == 0) {
      return CountriesListView();
    } else {
      return FavouriteView();
    }
  }
}
