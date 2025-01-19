// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel/core/error/excaption.dart';

import '../../../../api/urls.dart';
import '../models/destination_model.dart';

abstract class DestinationRemoteDataSource {
  Future<List<DestinationModel>> all();
  Future<List<DestinationModel>> top();
  Future<List<DestinationModel>> search(String query);
}

class DestinationRemoteDataSourceImpl implements DestinationRemoteDataSource {
  final http.Client client;

  DestinationRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<DestinationModel>> all() async {
    Uri url = Uri.parse('${URLs.base}/destination/all.php');
    final response = await client.get(url).timeout(const Duration(seconds: 3));

    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(Map.from(e))).toList();
    } else if (response.statusCode == 404){
     Map body = jsonDecode(response.body);
      throw NotFoundExcaption(message:body['message']);
    } else {
      throw ServerExcaption();
    }
  }

  @override
  Future<List<DestinationModel>> search(String query) async {
    Uri url = Uri.parse('${URLs.base}/destination/search.php');
    final response = await client.post(url, body: {
      'query' : query,
    }).timeout(const Duration(seconds: 3));

    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(Map.from(e))).toList();
    } else if (response.statusCode == 404){
      Map body = jsonDecode(response.body);
      throw NotFoundExcaption(message:body['message']);
    } else {
      throw ServerExcaption();
    }
  }

  @override
  Future<List<DestinationModel>> top() async {
    Uri url = Uri.parse('${URLs.base}/destination/top.php');
    final response = await client.get(url).timeout(const Duration(seconds: 3));
    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(Map.from(e))).toList();
    } else if (response.statusCode == 404){
      Map body = jsonDecode(response.body);
      throw NotFoundExcaption(message:body['message']);
    } else {
      throw ServerExcaption();
    }
  }
}
