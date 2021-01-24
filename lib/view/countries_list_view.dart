import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wellness/constants/size.dart';
import 'package:wellness/view_model/countries_list_vm.dart';
import 'package:wellness/view_model/favourite_vm.dart';
import 'package:wellness/widgets/widget.dart';

class CountriesListView extends StatefulWidget {
  @override
  _CountriesListViewState createState() => _CountriesListViewState();
}

class _CountriesListViewState extends State<CountriesListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Size _size;

  ConnectivityResult _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _size = Size(context);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await (Connectivity().checkConnectivity());
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result);
        break;
      default:
        setState(() => _connectionStatus = ConnectivityResult.none);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<FavouriteVm>(
      builder: (context, favVm, child) {
        if(_connectionStatus == ConnectivityResult.none){
          return Center(
            child: Text("Please check your network connectivity"),
          );
        }
        if (!favVm.isVmInitialized && favVm.countriesList == null) {
          favVm.init(context);
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Consumer<CountriesListVm>(
          builder: (context, vm, child) {
            if (!vm.isVmInitialized && vm.countriesList == null) {
              vm.init(context);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (vm.countriesList == null || vm.countriesList?.length == 0) {
              return getNoCountryRepresentation();
            }
            return Container(
              child: ListView.builder(
                itemCount: vm.countriesList.length + 1,
                itemBuilder: (context, index) {
                  if (index >= vm.countriesList.length) {
                    vm.fetchCountryList(context);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
                    child: Column(
                      children: [
                        getCountryCard(
                            vm.countriesList[index], favVm, _size, false),
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
      },
    );
  }

  Widget getNoCountryRepresentation() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_rounded,
              size: _size.width() / 3,
              color: Colors.black12,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hey,\nWe do not have any country to show",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
