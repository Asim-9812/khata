import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/model/filter%20model/filter_any_model.dart';


import '../../../../../core/api.dart';
import '../../../../../core/api_exception.dart';
import '../../../../../model/list model/get_list_model.dart';
import '../../../../../model/list model/list_model.dart';



final listProvider = FutureProvider.family.autoDispose((ref, GetListModel model) => ListProvider().getMenu(model));

final ledgerItemProvider = FutureProvider.family((ref, GetListModel model) => LedgerProvider().getLedgerItem(model));

class ListProvider{
  Future<List<Map<dynamic, dynamic>>> getMenu(GetListModel getListModel) async {
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

        for(final e in responseList[0]){
          group[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
        for(final e in responseList[1]){
          ledger[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
        for(final e in responseList[2]){
          branch[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
        myList = [group, ledger, branch];
      }else{
      }
      return myList;
    }on DioError catch(err){
      throw DioException().getDioError(err);
    }
  }
}

class LedgerProvider{
  Future<Map<dynamic, dynamic>> getLedgerItem(GetListModel getListModel) async {

    final dio = Dio();
    final jsonData = jsonEncode(getListModel.toJson());
    var ledger = {};
    try{
      final response = await dio.post(Api.getList, data: jsonData);
      if(response.statusCode == 200){
        final responseList = response.data as List<dynamic>;
        for(final e in responseList[0]){
          ledger[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
      }else{
      }
      return ledger;
    }on DioError catch(err){
      throw DioException().getDioError(err);
    }
  }
}


final newLedgerProvider = StateNotifierProvider<NewLedgerProvider, AsyncValue<Map<dynamic, dynamic>>>((ref) => NewLedgerProvider());

class NewLedgerProvider extends StateNotifier<AsyncValue<Map<dynamic, dynamic>>>{
  NewLedgerProvider() : super(const AsyncValue.data({}));

  Future<void> getLedgerItem(GetListModel getListModel) async {

    final dio = Dio();
    final jsonData = jsonEncode(getListModel.toJson());
    Map<dynamic, dynamic>ledger = {};
    try{
      final response = await dio.post(Api.getList, data: jsonData);
      if(response.statusCode == 200){
        final responseList = response.data;
        for(final e in responseList[0]){
          ledger[ListModel.fromJson(e).text!] = ListModel.fromJson(e).value!;
        }
      }else{
      }
      state = AsyncValue.data(ledger);
    }on DioError catch(err){
      throw DioException().getDioError(err);
    }
  }
}



final tableDataProvider = StateNotifierProvider<TableDataProvider, AsyncValue<List<dynamic>>>((ref) => TableDataProvider());

class TableDataProvider extends StateNotifier<AsyncValue<List<dynamic>>>{
  TableDataProvider() : super(const AsyncValue.data([]));

  Future<void> getTableValues(FilterAnyModel filterModel) async{
    final dio = Dio();
    try{
      final jsonData = jsonEncode(filterModel.toJson());
      final response = await dio.post(Api.getTable, data: jsonData);
      print(jsonData);
      if(response.statusCode == 200){
        final result = response.data as List<dynamic>;
        state = AsyncValue.data(result);
      }else{
        print(response.statusCode);
      }
    }on DioError catch(err){
      throw DioException().getDioError(err);
    }
  }
}


final modalDataProvider = StateNotifierProvider.autoDispose<ModalDataProvider, AsyncValue<List<dynamic>>>((ref) => ModalDataProvider());

class ModalDataProvider extends StateNotifier<AsyncValue<List<dynamic>>>{
  ModalDataProvider() : super(const AsyncValue.data([]));

  Future<void> getModalTableData(FilterAnyModel filterModel) async{
    final dio = Dio();
    try{
      final jsonData = jsonEncode(filterModel.toJson());
      final response = await dio.post(Api.getTable, data: jsonData);
      if(response.statusCode == 200){
        final result = response.data as List<dynamic>;
        state = AsyncValue.data(result);
      }else{
        print(response.statusCode);
      }
    }on DioError catch(err){
      throw DioException().getDioError(err);
    }
  }
}


















