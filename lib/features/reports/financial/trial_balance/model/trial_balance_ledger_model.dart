


class LedgerWiseModel {
  String? sno;
  int? ledgerId;
  int? accountGroupId;
  String? ledgerName;
  String? accountGroupName;
  String? nature;
  String? strOpening;
  String? strDebit;
  String? strCredit;
  String? strClosing;
  int? branchId;
  bool? isPageFooter;
  bool? isBold;
  bool? isItalic;

  LedgerWiseModel(
      {this.sno,
        this.ledgerId,
        this.accountGroupId,
        this.ledgerName,
        this.accountGroupName,
        this.nature,
        this.strOpening,
        this.strDebit,
        this.strCredit,
        this.strClosing,
        this.branchId,
        this.isPageFooter,
        this.isBold,
        this.isItalic});

  LedgerWiseModel.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    ledgerId = json['ledgerId'];
    accountGroupId = json['accountGroupId'];
    ledgerName = json['ledgerName'];
    accountGroupName = json['accountGroupName'];
    nature = json['nature'];
    strOpening = json['strOpening'];
    strDebit = json['strDebit'];
    strCredit = json['strCredit'];
    strClosing = json['strClosing'];
    branchId = json['branchId'];
    isPageFooter = json['isPageFooter'];
    isBold = json['isBold'];
    isItalic = json['isItalic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['ledgerId'] = ledgerId;
    data['accountGroupId'] = accountGroupId;
    data['ledgerName'] = ledgerName;
    data['accountGroupName'] = accountGroupName;
    data['nature'] = nature;
    data['strOpening'] = strOpening;
    data['strDebit'] = strDebit;
    data['strCredit'] = strCredit;
    data['strClosing'] = strClosing;
    data['branchId'] = branchId;
    data['isPageFooter'] = isPageFooter;
    data['isBold'] = isBold;
    data['isItalic'] = isItalic;
    return data;
  }
}
