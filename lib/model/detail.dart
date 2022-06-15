import 'package:json_annotation/json_annotation.dart';
part 'detail.g.dart';
@JsonSerializable()
class Detail{
  String name;
  String alpha2Code;
  String region;
  String capital;
  int population;
  String nativeName;
  Detail(this.name, this.alpha2Code, this.region, this.capital, this.population, this.nativeName);
  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}