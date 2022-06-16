import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_flutter_transformer2/dio_flutter_transformer2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/dio_cache_inter/dio_cache_data.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'interceptor_dio/app_path_provider.dart';
import 'screen/home_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized()
//   await AppPathProvider.initPath(); //initiallize path for offline cache

//   runApp(
//     ProviderScope(
//         child: const MyApp(),
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPathProvider.initPath(); //initiallize path for offline cache
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dio _dio = Dio();
    // final ApiService apiService = Get.put(ApiService());
    // _dio.interceptors.add(DioCacheInterceptor(options: options));
    // dio.interceptors.add(
    //     DioCacheManager(CacheConfig(baseUrl: "https://restcountries.com/v2/"))
    //         .interceptor);
    _dio.transformer = FlutterTransformer(); // for heavy json
    dio.interceptors
        .add(LogInterceptor(logPrint: (log) => print(log), requestBody: false));
    return const GetMaterialApp(
      home: HomePage(),
    );
  }
}
