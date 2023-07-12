
class ReportData {
  int? totalRecords;
  int? currentPageNumber;
  int? pageSize;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPreviousPage;
  int? totalFilterRecord;
  int? pageStartIndex;
  List<Data>? data;

  ReportData(
      {this.totalRecords,
        this.currentPageNumber,
        this.pageSize,
        this.totalPages,
        this.hasNextPage,
        this.hasPreviousPage,
        this.totalFilterRecord,
        this.pageStartIndex,
        this.data});

  ReportData.fromJson(Map<String, dynamic> json) {
    totalRecords = json['totalRecords'];
    currentPageNumber = json['currentPageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
    totalFilterRecord = json['totalfilterRecord'];
    pageStartIndex = json['pageStartIndex'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalRecords'] = totalRecords;
    data['currentPageNumber'] = currentPageNumber;
    data['pageSize'] = pageSize;
    data['totalPages'] = totalPages;
    data['hasNextPage'] = hasNextPage;
    data['hasPreviousPage'] = hasPreviousPage;
    data['totalfilterRecord'] = totalFilterRecord;
    data['pageStartIndex'] = pageStartIndex;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? ledgerId;
  int? accountGroupId;
  String? ledgerName;
  String? accountGroupName;
  String? nature;

  Data(
      {this.ledgerId,
        this.accountGroupId,
        this.ledgerName,
        this.accountGroupName,
        this.nature});

  Data.fromJson(Map<String, dynamic> json) {
    ledgerId = json['ledgerId'];
    accountGroupId = json['accountGroupId'];
    ledgerName = json['ledgerName'];
    accountGroupName = json['accountGroupName'];
    nature = json['nature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ledgerId'] = ledgerId;
    data['accountGroupId'] = accountGroupId;
    data['ledgerName'] = ledgerName;
    data['accountGroupName'] = accountGroupName;
    data['nature'] = nature;
    return data;
  }
}
