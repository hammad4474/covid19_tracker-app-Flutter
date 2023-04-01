// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:covid19_tracker/Models/world_stats_model.dart';
import 'package:covid19_tracker/Services/Utilities/stats_services.dart';
import 'package:covid19_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 6), vsync: this)
        ..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  StatsServices ss = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: ss.getWorldStatsRecord(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 2,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: [
                            const Color(0xff4285F4),
                            const Color(0xff1aa260),
                            const Color(0xffde5246)
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            elevation: 2,
                            child: Column(
                              children: [
                                ReuseableRow(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                ReuseableRow(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                ReuseableRow(
                                    title: "Deaths",
                                    value: snapshot.data!.recovered.toString()),
                                ReuseableRow(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                ReuseableRow(
                                    title: "Today Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff1aa260),
                            ),
                            child: Center(child: Text("Track Countries")),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
