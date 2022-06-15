import 'package:json_annotation/json_annotation.dart';
part 'country.g.dart';
@JsonSerializable()
class Country{
  String name;
  String alpha2Code;
  String region;
  Country(this.name, this.alpha2Code, this.region);
  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}




