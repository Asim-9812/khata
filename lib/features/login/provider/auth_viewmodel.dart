import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:khata_app/core/api.dart';
import 'package:khata_app/core/api_exception.dart';


import '../../../main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


final userLoginProvider = StateProvider((ref) => UserLogin());


class UserLogin {
  final dio = Dio();

  Future<String> login({required String databseId, required String username, required String password}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      try {
        final response = await dio.post(
          Api.userLogin,
          data: {
            "name": username,
            "password": password,
            "databseId": databseId,
          },
        );
        if (response.statusCode == 200 && response.data["userReturn"] != null && response.data["ownerCompanyList"] != null) {
          if(sessionBox.isEmpty){
            sessionBox.put('userReturn', jsonEncode(response.data));
          }
          // final companyInfo = response.data["ownerCompanyList"];
          // final userData = response.data["userReturn"];

          return 'success';
        }else{
          return response.data["authResult"]["errors"];
        }
      } on DioError catch (err) {
        throw DioException().getDioError(err);
      }
    }else{
      return 'No Internet Connection!!';
    }
  }
}

