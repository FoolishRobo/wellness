import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness/constants/size.dart';
import 'package:wellness/view_model/favourite_vm.dart';
import 'package:wellness/widgets/widget.dart';

class FavouriteView extends StatefulWidget {
  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  Size _size;

  @override
  void initState() {
    super.initState();
    _size = Size(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteVm>(
      builder: (context, vm, child) {
        if (!vm.isVmInitialized && vm.countriesList == null) {
          vm.init(context);
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (vm.countriesList == null || vm.countriesList?.length == 0) {
          return getNoFavouriteRepresentation();
        }
        return Container(
          child: ListView.builder(
            itemCount: vm.countriesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
                child: Column(
                  children: [
                    getCountryCard(vm.countriesList[index], vm, _size, true),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget getNoFavouriteRepresentation() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_sharp,
              size: _size.width() / 3,
              color: Colors.black12,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hey,\nYou do not have any favourite country!",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
