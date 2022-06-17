import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_restapi/model/detail.dart';

import '../model/country.dart';
import 'app_path_provider.dart';

const baseUrl = 'https://restcountries.com/v2/';

class ApiHelper {
  ApiHelper._() {
    _init(); //initiallze offline cache
  }

  static final ApiHelper _instance = ApiHelper._();
  static ApiHelper get instance => _instance;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    ),
  );

  //for cache of app
  void _init() async {
    _dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(AppPathProvider.path),
          policy: CachePolicy.refreshForceCache,
          hitCacheOnErrorExcept: [222],
          maxStale: const Duration(
            days: 3,
          ), //increase number of days for loger cache
          priority: CachePriority.high,
        ),
      ),
    );
    //this is for avoiding certificates error cause by dio
    //https://issueexplorer.com/issue/flutterchina/dio/1285

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<List<Country>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      print(res.data);
      if (res.statusCode == 200) {
        final responseData = (res.data) as List<dynamic>; // List
        final countryList = responseData
            .map((e) => Country.fromJson(e)) // get it
            .toList();
        return countryList;
      } else {
        final responseData = (res.data) as List<dynamic>; // List
        final countryList = responseData
            .map((e) => Country.fromJson(e)) // get it
            .toList();
        return countryList;
        // return [];
      }
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<List<Detail>> getDetail(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      final responseData = (res.data) as List<dynamic>; // List
      final detailList = responseData
          .map((e) => Detail.fromJson(e)) // get it
          .toList();
      return detailList;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  // /// return response body or throws [NetworkExceptions]
  // Future<dynamic> post(
  //   String uri, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   try {
  //     final res = await _dio.post(
  //       uri,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );
  //     return res.data;
  //   } on DioError catch (e) {
  //     throw e.toNetworkException();
  //   }
  // }

  // /// return response body or throws [NetworkExceptions]
  // Future<dynamic> put(
  //   String uri, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   try {
  //     final response = await _dio.put(
  //       uri,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );

  //     return response.data;
  //   } on DioError catch (e) {
  //     throw e.toNetworkException();
  //   }
  // }

  // /// return response body or throws [NetworkExceptions]
  // Future<dynamic> delete(
  //   String uri, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   try {
  //     final response = await _dio.delete(
  //       uri,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );

  //     return response.data;
  //   } on DioError catch (e) {
  //     throw e.toNetworkException();
  //   }
  // }
}
