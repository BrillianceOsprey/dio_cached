import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer2/dio_flutter_transformer2.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'apiservice/apiservice.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    final ApiService apiService = Get.put(ApiService(dio));
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://restcountries.com/v2/"))
            .interceptor);
    dio.transformer = FlutterTransformer(); // for heavy json
    dio.interceptors
        .add(LogInterceptor(logPrint: (log) => print(log), requestBody: false));
    return const GetMaterialApp(
      home: HomePage(),
    );
  }
}
