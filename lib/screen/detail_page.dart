import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/apiservice/apiservice.dart';
import 'package:flutter_restapi/model/country.dart';
import 'package:flutter_restapi/model/detail.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);
  ApiService _apiService = Get.find();

  @override
  Widget build(BuildContext context) {
    Country country = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: FutureBuilder<List<Detail>>(
          future: _apiService.getDetail(country.name),
          builder:
              (BuildContext context, AsyncSnapshot<List<Detail>> snapshot) {
            if (snapshot.hasData) {
              Detail detail = snapshot.data![0];
              return Column(
                children: [
                  Card(
                    child: CachedNetworkImage(
                        placeholder: (_, __) => Center(
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
              return Center(
                child: Text('Error'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
