class GroupWiseModel {
  String? sno;
  int? orderId;
  int? accountGroupId;
  String? accountGroupName;
  int? groupUnder;
  int? parentId;
  int? layerPosition;
  bool? isGroup;
  int? ledgerId;
  String? ledgerName;

  String? strDebit;
  String? strCredit;
  String? strBalance;
  int? branchId;
  String? voucherDate;
  String? nature;
  int? voucherTypeId;

  GroupWiseModel({
    this.sno,
    this.orderId,
    this.accountGroupId,
    this.accountGroupName,
    this.nature,
    this.groupUnder,
    this.parentId,
    this.layerPosition,
    this.isGroup,
    this.ledgerId,
    this.ledgerName,

    this.strDebit,
    this.strCredit,
    this.strBalance,
    this.voucherDate,
    this.branchId,
    this.voucherTypeId
  });

  GroupWiseModel.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    orderId = json['orderId'];
    accountGroupId = json['accountGroupId'];
    accountGroupName = json['accountGroupName'];
    nature = json['nature'];
    groupUnder = json['groupUnder'];
    parentId = json['parentId'];
    layerPosition = json['layerPosition'];
    isGroup = json['isGroup'];
    ledgerId = json['ledgerId'];
    ledgerName = json['ledgerName'];

    strDebit = json['strDebit'];
    strCredit = json['strCredit'];
    strBalance = json['strBalance'];
    branchId = json['branchID'];
    voucherDate = json['voucherDate'];
    voucherTypeId = json['voucherTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['orderId'] = orderId;
    data['accountGroupId'] = accountGroupId;
    data['accountGroupName'] = accountGroupName;
    data['nature'] = nature;
    data['groupUnder'] = groupUnder;
    data['parentId'] = parentId;
    data['layerPosition'] = layerPosition;
    data['isGroup'] = isGroup;
    data['ledgerId'] = ledgerId;
    data['ledgerName'] = ledgerName;
    data['strDebit'] = strDebit;
    data['strCredit'] = strCredit;
    data['branchId'] = branchId;
    data['voucherDate'] = voucherDate;
    data['voucherTypeId'] = voucherTypeId;
    return data;
  }
}
