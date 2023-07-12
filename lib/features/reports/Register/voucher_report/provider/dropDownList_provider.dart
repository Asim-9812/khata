




import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/core/api.dart';
import 'package:khata_app/core/api_exception.dart';
import 'package:khata_app/model/list%20model/get_list_model.dart';
import 'package:khata_app/model/list%20model/list_model.dart';


final voucherListProvider = FutureProvider.family.autoDispose((ref, GetListModel model) => VoucherListProvider().getDropDownList(model));


class VoucherListProvider{
  Future<List<Map<dynamic, dynamic>>> getDropDownList(GetListModel getListModel) async {
    final dio = Dio();
    final jsonData = jsonEncode(getListModel.toJson());
    List<Map<dynamic, dynamic>> myList = [];
    try{
      final response = await dio.post(Api.getList, data: jsonData);

      if(response.statusCode == 200){
        final responseList = response.data as List<dynamic>;
        var group = {};
        var ledger = {};
        var branch = {};
        var voucherType = {};

        for(final e in responseList[0]){
          group[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
        for(final e in responseList[1]){
          ledger[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
        for(final e in responseList[2]){
          branch[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
        for(final e in responseList[3]){
          voucherType[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
        myList = [group, ledger, branch, voucherType];
      }else{
      }
      return myList;
    }on DioError catch(err){
      throw DioException().getDioError(err);
    }
  }
}