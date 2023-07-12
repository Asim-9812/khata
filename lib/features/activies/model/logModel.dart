

class LogModel {
  int? logId;
  String? ipaddress;
  String? macAddress;
  String? hostAddress;
  String? userId;
  String? statusMessage;
  String? status;
  String? contact;
  String? email;
  String? name;
  String? logInTime;
  String? sessionId;


  LogModel(
      {this.logId,
        this.ipaddress,
        this.macAddress,
        this.hostAddress,
        this.userId,
        this.statusMessage,
        this.status,
        this.contact,
        this.email,
        this.name,
        this.logInTime,
        this.sessionId,
      });

  LogModel.fromJson(Map<String, dynamic> json) {
    logId = json['logid'];
    ipaddress = json['ipaddress'];
    macAddress = json['macAddress'];
    hostAddress = json['hostAddress'];
    userId = json['userId'];
    statusMessage = json['statusMessage'];
    status = json['status'];
    contact = json['contact'];
    email = json['email'];
    name = json['name'];
    logInTime = json['logInTime'];
    sessionId = json['sessionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logid'] = logId;
    data['ipaddress'] = ipaddress;
    data['macAddress'] = macAddress;
    data['hostAddress'] = hostAddress;
    data['userId'] = userId;
    data['statusMessage'] = statusMessage;
    data['status'] = status;
    data['contact'] = contact;
    data['email'] = email;
    data['name'] = name;
    data['logInTime'] = logInTime;
    data['sessionId'] = sessionId;

    return data;
  }
}
