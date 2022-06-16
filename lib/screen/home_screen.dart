import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../interceptor_dio/base_client_full code.dart';
import '../model/country.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ApiService _apiService = Get.find();

  @override
  Widget build(BuildContext context) {
    // final options =
    //     buildCacheOptions(const Duration(days: 7), forceRefresh: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Flag'),
      ),
      body: FutureBuilder<List<Country>>(
        future: ApiHelper.instance.get('https://restcountries.com/v2/all'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return countryCard(context, snapshot.data![index]);
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget countryCard(BuildContext context, Country country) {
    return Card(
      child: ListTile(
        onTap: () {
          Get.to(const DetailPage(), arguments: country);
        },
        leading: CachedNetworkImage(
            width: 50,
            height: 50,
            placeholder: (context, url) {
              return const Center(child: CircularProgressIndicator());
            },
            imageUrl: 'https://countryflagsapi.com/png/${country.alpha2Code}'),
        title: Text(country.name),
      ),
    );
  }
}
