



class NotificationModel {
  int? id;
  int? nTypeId;
  String? description;
  bool? isActive;
  String? entryDate;
  String? notificationType;

  NotificationModel({
    this.id,
    this.nTypeId,
    this.description,
    this.isActive,
    this.entryDate,
    this.notificationType,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nTypeId = json['ntypeid'];
    description = json['description'];
    isActive = json['isactive'];
    entryDate = json['entrydate'];
    notificationType = json['notificationtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ntypeid'] = nTypeId;
    data['description'] = description;
    data['isactive'] = isActive;
    data['entrydate'] = entryDate;
    data['notificationtype'] = notificationType;
    return data;
  }
}