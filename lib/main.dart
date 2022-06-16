import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer2/dio_flutter_transformer2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'interceptor_dio/app_path_provider.dart';
import 'screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPathProvider.initPath(); //initiallize path for offline cache
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dio _dio = Dio();
    _dio.transformer = FlutterTransformer(); // for heavy json
    _dio.interceptors
        .add(LogInterceptor(logPrint: (log) => print(log), requestBody: false));
    return const GetMaterialApp(
      home: HomePage(),
    );
  }
}
