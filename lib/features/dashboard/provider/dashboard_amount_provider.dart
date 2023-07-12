


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/core/api.dart';
import 'package:khata_app/core/api_exception.dart';
import 'package:khata_app/features/dashboard/model/dashboard_amount_model.dart';
import 'package:khata_app/model/list%20model/get_list_model.dart';

final dashBoardDataProvider = FutureProvider.family((ref, MainInfoModel model) => DashboardAmountProvider().fetchDashboardData(model));

class DashboardAmountProvider {

  Future<List<Map<String, dynamic>>> fetchDashboardData(MainInfoModel infoModel) async{
    final dio = Dio();
    List<DashboardAmountModel> dashboardAmountList = [];
    List<Map<String, dynamic>> dashList = [];
    try{

      final jsonData = jsonEncode(infoModel.toJson());
      final response = await dio.post(Api.getDashBoardAmount, data: jsonData);
      if(response.statusCode == 200){
        final result = response.data as List<dynamic>;
        for (var element in result) {
          dashboardAmountList.add(DashboardAmountModel.fromJson(element));
        }

        for(var e in dashboardAmountList){
          if(e.accountGroupId == 11 || e.accountGroupId == 14){
            dashList.add(
                {
                  "nature": e.accountGroupName,
                  "total": (e.debit! - e.credit!)
                }
            );
          }else{
            dashList.add(
                {
                  "nature": e.accountGroupName,
                  "total": e.closingBalances
                }
            );
          }
        }

      }else{
        print(response.statusCode);
      }
      return dashList;
    }on DioError catch(err){
      throw DioException().getDioError(err);
    }
  }
}