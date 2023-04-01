import 'dart:convert';

import 'package:covid19_tracker/Models/countries_list_model.dart';
import 'package:covid19_tracker/Models/world_stats_model.dart';
import 'package:covid19_tracker/View/countries_list.dart';
import 'package:http/http.dart' as http;

import 'app_url.dart';

class StatsServices {
  Future<WorldStatsModel> getWorldStatsRecord() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception("error");
    }
  }

  Future<List<dynamic>> getWorldCountries() async {
    var data;
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("error");
    }
  }
}
