import 'package:dio_flutter_transformer2/dio_flutter_transformer2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/apiservice/apiservice.dart';
import 'package:flutter_restapi/screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    ApiService apiService = Get.put(ApiService(dio));
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://restcountries.com/v2/"))
            .interceptor);
    dio.transformer = FlutterTransformer(); // for heavy json
    dio.interceptors
        .add(LogInterceptor(logPrint: (log) => print(log), requestBody: false));
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}
