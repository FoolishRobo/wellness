import 'package:flutter/material.dart';
import 'package:wellness/constants/app_colors.dart';
import 'package:wellness/constants/size.dart';
import 'package:wellness/model/countries_model.dart';
import 'package:wellness/view_model/favourite_vm.dart';

Widget getCountryCard(
    Countries countries, FavouriteVm vm, Size _size, bool isFav) {
  return InkWell(
    onTap: () {
      if (!isFav) vm.addOrRemoveFavourite(countries);
    },
    child: Container(
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: isFav
                  ? AppColors.favouriteColorNotSeleceted
                  : AppColors.countryColorNotSeleceted,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: Text(
                countries.abbriviation,
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: _size.width() - 140,
                        child: Text(
                          countries.countryDetail.country,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        countries.countryDetail.region,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              vm.contains(countries)
                  ? Icon(
                      Icons.favorite,
                      color: AppColors.favouriteColorNotSeleceted,
                    )
                  : Icon(
                      Icons.favorite_outline,
                      color: AppColors.favouriteColorNotSeleceted,
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}
