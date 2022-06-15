import 'package:flutter_restapi/model/country.dart';
import 'package:flutter_restapi/model/detail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
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
