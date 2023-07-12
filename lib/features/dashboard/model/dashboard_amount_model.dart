class DashboardAmountModel {
  int? orderId;
  int? accountGroupId;
  String? accountGroupName;
  String? nature;
  int? groupUnder;
  int? parentId;
  int? layerPosition;
  bool? isGroup;
  int? ledgerId;
  num? debit;
  num? credit;
  num? openingBalances;
  num? closingBalances;

  DashboardAmountModel(
      {this.orderId,
        this.accountGroupId,
        this.accountGroupName,
        this.nature,
        this.groupUnder,
        this.parentId,
        this.layerPosition,
        this.isGroup,
        this.ledgerId,
        this.debit,
        this.credit,
        this.openingBalances,
        this.closingBalances});

  DashboardAmountModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    accountGroupId = json['accountGroupId'];
    accountGroupName = json['accountGroupName'];
    nature = json['nature'];
    groupUnder = json['groupUnder'];
    parentId = json['parentId'];
    layerPosition = json['layerPosition'];
    isGroup = json['isGroup'];
    ledgerId = json['ledgerId'];
    debit = json['debit'];
    credit = json['credit'];
    openingBalances = json['openingBalances'];
    closingBalances = json['closingBalances'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['accountGroupId'] = accountGroupId;
    data['accountGroupName'] = accountGroupName;
    data['nature'] = nature;
    data['groupUnder'] = groupUnder;
    data['parentId'] = parentId;
    data['layerPosition'] = layerPosition;
    data['isGroup'] = isGroup;
    data['ledgerId'] = ledgerId;
    data['debit'] = debit;
    data['credit'] = credit;
    data['openingBalances'] = openingBalances;
    data['closingBalances'] = closingBalances;
    return data;
  }
}
