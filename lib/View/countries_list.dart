// ignore_for_file: sort_child_properties_last

import 'package:covid19_tracker/Models/countries_list_model.dart';
import 'package:covid19_tracker/Services/Utilities/stats_services.dart';
import 'package:covid19_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  StatsServices ss = StatsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (Value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: ss.getWorldCountries(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey.shade100);
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              name: snapshot.data![index]
                                                  ['country'],
                                              death: snapshot.data![index]
                                                  ['death'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            )));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index]['country']
                                        .toString()),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot
                                            .data![index]['countryInfo']['flag']
                                            .toString())),
                                  ),
                                ],
                              ),
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  death: snapshot.data![index]
                                                      ['death'],
                                                  critical: snapshot
                                                      .data![index]['critical'],
                                                )));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']
                                        .toString()),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot
                                            .data![index]['countryInfo']['flag']
                                            .toString())),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }));
                  }
                }),
          ),
        ],
      )),
    );
  }
}
