




import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/core/api.dart';
import 'package:khata_app/features/activies/model/logModel.dart';

import '../model/entry_master_model.dart';

final logProvider = StreamProvider.autoDispose<List<LogModel>>((ref) async* {
  final dio = Dio();

  try{
    final response = await dio.post(Api.getLoginActivities,
      data: {
        "logid": 0,
        "ipaddress": "string",
        "macAddress": "string",
        "hostAddress": "string",
        "userId": "string",
        "statusMessage": "string",
        "status": "string",
        "contact": "string",
        "email": "string",
        "name": "string",
        "logInTime": "2023-05-09T10:46:15.304Z",
        "sessionId": "string",
        "dbName": "KhataC_00001"
      }
    );

    if (response.statusCode == 200) {
      final result = response.data["result"] as List<dynamic>;
      final logModel = result.map((e) => LogModel.fromJson(e)).toList();
      yield logModel;
    } else {
      throw Exception('Failed to load logs');
    }
  }on DioError catch(err){
    throw err.message;
  }

});


Future<List<LogModel>> fetchLogActivities(StreamController logStreamController, String token) async {

  try{
    final dio = Dio(
        BaseOptions(
          connectTimeout: 30000,
          baseUrl: Api.getLoginActivities,
          responseType: ResponseType.json,
        ));

    dio.options.headers["Authorization"] = "Bearer $token";

    final response = await dio.post(Api.getLoginActivities,
        data: {
          "logid": 0,
          "ipaddress": "string",
          "macAddress": "string",
          "hostAddress": "string",
          "userId": "string",
          "statusMessage": "string",
          "status": "string",
          "contact": "string",
          "email": "string",
          "name": "string",
          "logInTime": "2023-05-09T10:46:15.304Z",
          "sessionId": "string",
          "dbName": "KhataC_00001"
        },
    );
    if (response.statusCode == 200) {
      final result = response.data["result"] as List<dynamic>;
      final logModel = result.map((e) => LogModel.fromJson(e)).toList();
      logStreamController.add(logModel);
      return logModel;
    } else {
      throw Exception('Failed to load logs');
    }
  }on DioError catch(err){
    throw err.message;
  }
}


Future<List<EntryMaster>> fetchTransactionActivities(StreamController transactionStreamController) async {
  final dio = Dio();

  try{
    final response = await dio.post(Api.getLoginActivities,
        data: {
          "name": "string",
          "username": "string",
          "voucherTypeName": "string",
          "voucherNo": "string",
          "entryDate": "2023-05-12T06:31:03.862Z",
          "dbName": "KhataC_00001"
        }
    );

    if (response.statusCode == 200) {
      final result = response.data["result"] as List<dynamic>;
      final entryMasterModel = result.map((e) => EntryMaster.fromJson(e)).toList();
      return entryMasterModel;
    } else {
      throw Exception('Failed to load logs');
    }
  }on DioError catch(err){
    throw err.message;
  }
}





final entryMasterProvider = StreamProvider<List<EntryMaster>>((ref) async* {
  final dio = Dio();

  try{
    final response = await dio.post(Api.getTransactionActivities,
        data: {
          "name": "string",
          "username": "string",
          "voucherTypeName": "string",
          "voucherNo": "string",
          "entryDate": "2023-05-12T06:31:03.862Z",
          "dbName": "KhataC_00001"
        }
    );

    if (response.statusCode == 200) {
      final result = response.data["result"] as List<dynamic>;
      final entryMasterModel = result.map((e) => EntryMaster.fromJson(e)).toList();
      yield entryMasterModel;
    } else {
      throw Exception('Failed to load logs');
    }
  }on DioError catch(err){
    throw err.message;
  }

});
