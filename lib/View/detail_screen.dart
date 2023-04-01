import 'package:covid19_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailScreen extends StatefulWidget {
  String name;
  int? death, critical;
  DetailScreen(
      {super.key,
      required this.name,
      required this.death,
      required this.critical});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Card(
                  child: Column(
                    children: [
                      ReuseableRow(title: "Name", value: widget.name),
                      ReuseableRow(
                          title: "Active", value: widget.death.toString()),
                      ReuseableRow(
                          title: "Critical", value: widget.critical.toString()),
                      ReuseableRow(
                          title: "todayRecovered",
                          value: widget.critical.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
