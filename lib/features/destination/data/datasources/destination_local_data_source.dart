import 'dart:convert';

import 'package:travel/core/error/excaption.dart';
import 'package:travel/features/destination/data/models/destination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cacheAllDestinationKey = 'all_destination';

abstract class DestinationLocalDataSource {
  Future<List<DestinationModel>> getAll();
  Future<bool> cachedAll(List<DestinationModel> list);

}

class DestinationLocalDataSourceImp implements DestinationLocalDataSource {
  final SharedPreferences pref;

  DestinationLocalDataSourceImp({required this.pref});


  @override
  Future<bool> cachedAll(List<DestinationModel> list) async {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allDestination = jsonEncode(listMap);
   return pref.setString(cacheAllDestinationKey, allDestination);
  }

  @override
  Future<List<DestinationModel>> getAll() async {
    String? allDestination = pref.getString(cacheAllDestinationKey);
    if(allDestination != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(jsonDecode(allDestination));
      List<DestinationModel> list =  listMap.map((e) => DestinationModel.fromJson(e)).toList();
      return list;
    } 
    throw CachedExcaption();
  }

}