// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Countries _$CountriesFromJson(Map<String, dynamic> json) {
  return Countries(
    abbriviation: json['abbriviation'] as String,
    countryDetail: json['countryDetail'] == null
        ? null
        : Country.fromJson(json['countryDetail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'abbriviation': instance.abbriviation,
      'countryDetail': instance.countryDetail,
    };

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    country: json['country'] as String,
    region: json['region'] as String,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'country': instance.country,
      'region': instance.region,
    };
