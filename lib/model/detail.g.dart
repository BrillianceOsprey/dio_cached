// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Detail _$DetailFromJson(Map<String, dynamic> json) {
  return Detail(
    json['name'] as String,
    json['alpha2Code'] as String,
    json['region'] as String,
    json['capital'] as String,
    json['population'] as int,
    json['nativeName'] as String,
  );
}

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'name': instance.name,
      'alpha2Code': instance.alpha2Code,
      'region': instance.region,
      'capital': instance.capital,
      'population': instance.population,
      'nativeName': instance.nativeName,
    };
