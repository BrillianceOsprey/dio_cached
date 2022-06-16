// import 'dart:convert';

// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
// import 'package:flutter_restapi/dio_cache_inter/dio_cache_data.dart';

// import '../model/country.dart';

// class ApiService {
//   Future<List<Country>> getCountry() async {
//     final response = await dio.get(
//       'https://restcountries.com/v2/all',
//       options: options.copyWith(policy: CachePolicy.refresh).toOptions(),
//     );
//     if (response.statusCode == 200) {
//       final responseData = (response.data) as List<dynamic>; // List
//       final countryList = responseData
//           .map((e) => Country.fromJson(e)) // get it
//           // .map((e) => Country(e['name'], e['alpha2Code'], e['region']))// got it
//           .toList();
//       return countryList;
//     }
//     return [];
//   }
// }
