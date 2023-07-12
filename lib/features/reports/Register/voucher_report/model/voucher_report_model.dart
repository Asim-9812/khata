
class VoucherReportModel {
  String? sno;
  int? masterId;
  String? voucherDate;
  String? strVoucherDate;
  String? voucherNo;
  String? refNo;
  int? voucherId;
  String? voucherName;
  String? particulars;
  String? strAmount;
  String? narration;
  bool? status;
  String? strStatus;
  int? layerPosition;
  bool? isSubLedger;
  bool? isParent;

  VoucherReportModel(
      {this.sno,
        this.masterId,
        this.voucherDate,
        this.strVoucherDate,
        this.voucherNo,
        this.refNo,
        this.voucherId,
        this.voucherName,
        this.particulars,
        this.strAmount,
        this.narration,
        this.status,
        this.strStatus,
        this.layerPosition,
        this.isSubLedger,
        this.isParent});

  VoucherReportModel.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    masterId = json['masterId'];
    voucherDate = json['voucherDate'];
    strVoucherDate = json['strVoucherDate'];
    voucherNo = json['voucherNo'];
    refNo = json['refNo'];
    voucherId = json['voucherId'];
    voucherName = json['voucherName'];
    particulars = json['particulars'];
    strAmount = json['strAmount'];
    narration = json['narration'];
    status = json['status'];
    strStatus = json['strStatus'];
    layerPosition = json['layerPosition'];
    isSubLedger = json['isSubLedger'];
    isParent = json['isParent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['masterId'] = masterId;
    data['voucherDate'] = voucherDate;
    data['strVoucherDate'] = strVoucherDate;
    data['voucherNo'] = voucherNo;
    data['refNo'] = refNo;
    data['voucherId'] = voucherId;
    data['voucherName'] = voucherName;
    data['particulars'] = particulars;
    data['strAmount'] = strAmount;
    data['narration'] = narration;
    data['status'] = status;
    data['strStatus'] = strStatus;
    data['layerPosition'] = layerPosition;
    data['isSubLedger'] = isSubLedger;
    data['isParent'] = isParent;
    return data;
  }
}
