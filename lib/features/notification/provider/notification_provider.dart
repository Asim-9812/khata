



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/core/api.dart';

import '../model/notification_model.dart';



final notificationProvider = FutureProvider.family((ref, String token) => NotificationProvider().getNotifications(token: token));
class NotificationProvider{

  Future<List<NotificationModel>> getNotifications({required String token}) async{
    final dio = Dio();
    // Step 1: Check token expiration
    bool isTokenExpired(String token) {
      final jwt = token.split(".");
      final payload = base64Url.decode(jwt[1]);
      final jsonPayload = utf8.decode(payload);
      final expiration = json.decode(jsonPayload)["exp"];
      final currentDateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return currentDateTime > expiration;
    }

    if (isTokenExpired(token)) {

      throw "Token expired";
    }
    try{
      final response = await dio.get(Api.getNotification,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );

      if(response.statusCode == 200){
        final result = response.data["result"] as List<dynamic>;
        final notificationList = result.map((e) => NotificationModel.fromJson(e)).toList();
        return notificationList;
      }else{
        return [];
      }
    }on DioError catch(err){
      throw err.message;
    }
  }
}