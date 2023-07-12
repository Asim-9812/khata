class VoucherIndividualReportModel {
  String? sno;
  int? ledgerId;
  int? mainledgerId;
  int? subledgerId;
  String? ledgerName;
  String? dr;
  String? cr;
  String? chequeNo;
  String? chequeDate;
  int? voucherTypeId;
  String? narration;
  bool? isSubLedger;
  bool? hasChild;
  int? masterId;

  VoucherIndividualReportModel(
      {this.sno,
        this.ledgerId,
        this.mainledgerId,
        this.subledgerId,
        this.ledgerName,
        this.dr,
        this.cr,
        this.chequeNo,
        this.chequeDate,
        this.voucherTypeId,
        this.narration,
        this.isSubLedger,
        this.hasChild,
        this.masterId});

  VoucherIndividualReportModel.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    ledgerId = json['ledgerId'];
    mainledgerId = json['mainledgerId'];
    subledgerId = json['subledgerId'];
    ledgerName = json['ledgerName'];
    dr = json['dr'];
    cr = json['cr'];
    chequeNo = json['chequeNo'];
    chequeDate = json['chequeDate'];
    voucherTypeId = json['voucherTypeId'];
    narration = json['narration'];
    isSubLedger = json['isSubLedger'];
    hasChild = json['hasChild'];
    masterId = json['masterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['ledgerId'] = ledgerId;
    data['mainledgerId'] = mainledgerId;
    data['subledgerId'] = subledgerId;
    data['ledgerName'] = ledgerName;
    data['dr'] = dr;
    data['cr'] = cr;
    data['chequeNo'] = chequeNo;
    data['chequeDate'] = chequeDate;
    data['voucherTypeId'] = voucherTypeId;
    data['narration'] = narration;
    data['isSubLedger'] = isSubLedger;
    data['hasChild'] = hasChild;
    data['masterId'] = masterId;
    return data;
  }
}
