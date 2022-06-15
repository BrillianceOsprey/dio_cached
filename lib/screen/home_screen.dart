import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/apiservice/apiservice.dart';
import 'package:flutter_restapi/model/country.dart';
import 'package:flutter_restapi/screen/detail_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  ApiService _apiService = Get.find();

  @override
  Widget build(BuildContext context) {
    final options = buildCacheOptions(Duration(days: 7), forceRefresh: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Flag'),
      ),
      body: FutureBuilder<List<Country>>(
        future: _apiService.getCountry(options),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return CountryCard(context, snapshot.data![index]);
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget CountryCard(BuildContext context, Country country) {
    return Card(
      child: ListTile(
        onTap: () {
          Get.to(DetailPage(), arguments: country);
        },
        leading: CachedNetworkImage(
            width: 50,
            height: 50,
            placeholder: (context, url) {
              return Center(child: CircularProgressIndicator());
            },
            imageUrl: 'https://countryflagsapi.com/png/${country.alpha2Code}'),
        title: Text(country.name),
      ),
    );
  }
}
