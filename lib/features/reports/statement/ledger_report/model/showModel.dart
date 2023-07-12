class ShowModal {
  String? sno;
  String? voucherDate;
  bool? isSubLedger;
  int? voucherTypeId;
  String? voucherTypeName;
  String? voucherNo;
  int? invoiceNo;
  String? refNo;
  String? chequeNo;
  int? ledgerId;
  String? ledgerName;
  String? particular;
  String? strDebit;
  String? strCredit;
  String? strBalance;
  int? masterId;
  String? narration;
  bool? topLedger;

  ShowModal(
      {this.sno,
        this.voucherDate,
        this.isSubLedger,
        this.voucherTypeId,
        this.voucherTypeName,
        this.voucherNo,
        this.invoiceNo,
        this.refNo,
        this.chequeNo,
        this.ledgerId,
        this.ledgerName,
        this.particular,
        this.strDebit,
        this.strCredit,
        this.strBalance,
        this.masterId,
        this.narration,
        this.topLedger});

  ShowModal.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    voucherDate = json['voucherDate'];
    isSubLedger = json['isSubLedger'];
    voucherTypeId = json['voucherTypeId'];
    voucherTypeName = json['voucherTypeName'];
    voucherNo = json['voucherNo'];
    invoiceNo = json['invoiceNo'];
    refNo = json['refNo'];
    chequeNo = json['chequeNo'];
    ledgerId = json['ledgerId'];
    ledgerName = json['ledgerName'];
    particular = json['particular'];
    strDebit = json['strDebit'];
    strCredit = json['strCredit'];
    strBalance = json['strBalance'];
    masterId = json['masterId'];
    narration = json['narration'];
    topLedger = json['topLedger'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['voucherDate'] = voucherDate;
    data['isSubLedger'] = isSubLedger;
    data['voucherTypeId'] = voucherTypeId;
    data['voucherTypeName'] = voucherTypeName;
    data['voucherNo'] = voucherNo;
    data['invoiceNo'] = invoiceNo;
    data['refNo'] = refNo;
    data['chequeNo'] = chequeNo;
    data['ledgerId'] = ledgerId;
    data['ledgerName'] = ledgerName;
    data['particular'] = particular;
    data['strDebit'] = strDebit;
    data['strCredit'] = strCredit;
    data['strBalance'] = strBalance;
    data['masterId'] = masterId;
    data['narration'] = narration;
    data['topLedger'] = topLedger;
    return data;
  }
}
