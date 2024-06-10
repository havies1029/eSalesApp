import 'dart:convert';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esalesapp/models/jobreal/jobrealcari_model.dart';

class JobRealCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/jobreal/jobrealcari/getlist";

  Future<List<JobRealCariModel>> getJobRealCariAPI(String filterDoc,
      String searchText, int hal) async {

    debugPrint("getJobRealCariAPI");    
    debugPrint("urlGetListEndPoint : $urlGetListEndPoint");

    Map<String, String> queryParams = {
      "searchText": searchText,
      "filterDoc": filterDoc,
      "hal": hal.toString()
    };
    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("getJobRealCariAPI");
    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<JobRealCariModel>((json) => JobRealCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
