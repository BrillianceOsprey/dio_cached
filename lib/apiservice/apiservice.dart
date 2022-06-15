import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/country.dart';
import '../model/detail.dart';

part 'apiservice.g.dart';

@RestApi(baseUrl: 'https://restcountries.com/v2/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;
  @GET('/all')
  Future<List<Country>> getCountry(@DioOptions() Options options);
  @GET('/name/{name}?fullText=true')
  Future<List<Detail>> getDetail(
      @Path('name') String name, @DioOptions() Options options);
}
