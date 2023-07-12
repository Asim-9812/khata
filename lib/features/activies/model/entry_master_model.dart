


class EntryMaster {
  String? name;
  String? username;
  String? voucherTypeName;
  String? voucherNo;
  String? entryDate;


  EntryMaster(
      {this.name,
        this.username,
        this.voucherTypeName,
        this.voucherNo,
        this.entryDate,
       });

  EntryMaster.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    voucherTypeName = json['voucherTypeName'];
    voucherNo = json['voucherNo'];
    entryDate = json['entryDate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['voucherTypeName'] = voucherTypeName;
    data['voucherNo'] = voucherNo;
    data['entryDate'] = entryDate;

    return data;
  }
}