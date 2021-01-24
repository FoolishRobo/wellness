import 'package:json_annotation/json_annotation.dart';

part 'countries_model.g.dart';

@JsonSerializable()
class Countries {
  Countries({this.abbriviation, this.countryDetail});

  String abbriviation;
  Country countryDetail;

  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesToJson(this);

  Countries.fromMap(Map<String, dynamic> map) {
    abbriviation = map["row"][0];
    countryDetail = Country(
        country: ["row"][1],
        region: ["row"][2]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "abbriviation": abbriviation,
      "country": countryDetail.country,
      "region": countryDetail.region
    };
    if (abbriviation != null) {
      map["abbriviation"] = abbriviation;
    }
    return map;
  }
}

@JsonSerializable()
class Country {
  String country;
  String region;

  Country({this.country, this.region});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  Country.fromMap(Map<String, dynamic> map) {
    country = map["country"];
    region = map["region"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{"country": country, "region": region};
    return map;
  }
}
