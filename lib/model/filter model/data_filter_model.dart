
class DataFilterModel{

  String? tblName;
  String? strName;
  String? columnName;
  String? underColumnName;
  double? underIntID;
  String? filterColumnsString;
  int? currentPageNumber;
  int? pageRowCount;
  String? strListNames;


  DataFilterModel({
    this.tblName,
    this.strName,
    this.columnName,
    this.underColumnName,
    this.underIntID,
    this.filterColumnsString,
    this.currentPageNumber,
    this.pageRowCount,
    this.strListNames
  });


  factory DataFilterModel.fromJson(Map<String, dynamic> json){
    return DataFilterModel(
        tblName: json["tblName"],
        strName: json["columnName"],
        underColumnName: json["underColumnName"],
        underIntID: json["underIntID"],
        filterColumnsString: json["filterColumnsString"],
        currentPageNumber: json["currentPageNumber"],
        pageRowCount: json["pageRowCount"],
        strListNames: json["strListNames"]
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["tblName"] = tblName;
    data["strName"] = strName;
    data["columnName"] = columnName;
    data["underColumnName"] = underColumnName;
    data["underIntID"] = underIntID;
    data["filterColumnsString"] = filterColumnsString;
    data["currentPageNumber"] = currentPageNumber;
    data["pageRowCount"] = pageRowCount;
    data["strListNames"] = strListNames;
    return data;
  }

}