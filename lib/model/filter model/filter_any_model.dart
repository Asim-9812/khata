import 'package:khata_app/model/filter%20model/data_filter_model.dart';
import 'package:khata_app/model/list%20model/get_list_model.dart';

class FilterAnyModel{
  DataFilterModel? dataFilterModel;
  MainInfoModel? mainInfoModel;


  FilterAnyModel({this.dataFilterModel, this.mainInfoModel});

  FilterAnyModel.fromJson(Map<String, dynamic> json){
    dataFilterModel = json["dataFilterModel"] != null ? DataFilterModel.fromJson(json["dataFilterModel"]) : null;
    mainInfoModel = json["mainInfoModel"] != null ? MainInfoModel.fromJson(json["mainInfoModel"]) : null;

  }


  Map<String, dynamic> toJson(){
    final Map<String, dynamic>  data = <String, dynamic>{};
    if (mainInfoModel != null) {
      data['mainInfoModel'] = mainInfoModel!.toJson();
    }
    if (dataFilterModel != null) {
      data['dataFilterModel'] = dataFilterModel!.toJson();
    }

     return data;
  }



}