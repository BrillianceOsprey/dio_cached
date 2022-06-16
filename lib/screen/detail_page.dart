import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/interceptor_dio/base_client_full%20code.dart';
import 'package:get/get.dart';

import '../model/country.dart';
import '../model/detail.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // final ApiService _apiService = Get.find();

  @override
  Widget build(BuildContext context) {
    // final options =
    //     buildCacheOptions(const Duration(days: 7), forceRefresh: true);
    Country country = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: FutureBuilder<List<Detail>>(
          future: ApiHelper.instance.getDetail(
              'https://restcountries.com/v2/name/${country.name}?fullText=true'),
          builder:
              (BuildContext context, AsyncSnapshot<List<Detail>> snapshot) {
            if (snapshot.hasData) {
              Detail detail = snapshot.data![0];
              return Column(
                children: [
                  Card(
                    child: CachedNetworkImage(
                        placeholder: (_, __) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        width: double.infinity,
                        height: 200,
                        imageUrl:
                            'https://countryflagsapi.com/png/${snapshot.data![0].alpha2Code}'),
                  ),
                  Text(detail.capital),
                  Text(detail.region),
                  Text(detail.population.toString()),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
