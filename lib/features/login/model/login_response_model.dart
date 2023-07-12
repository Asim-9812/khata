class LoginResponse {
  UserReturn? userReturn;
  List<DepartmentBranches>? departmentBranches;
  FiscalYearInfo? fiscalYearInfo;
  AuthResult? authResult;
  OwnerCompanyList? ownerCompanyList;
  OtherInfo? otherInfo;

  LoginResponse({
    this.userReturn,
    this.departmentBranches,
    this.fiscalYearInfo,
    this.authResult,
    this.ownerCompanyList,
    this.otherInfo,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    userReturn = json['userReturn'] != null
        ? UserReturn.fromJson(json['userReturn'])
        : null;
    if (json['departmentBranches'] != null) {
      departmentBranches = <DepartmentBranches>[];
      json['departmentBranches'].forEach((v) {
        departmentBranches!.add(DepartmentBranches.fromJson(v));
      });
    }
    fiscalYearInfo = json['fiscalYearInfo'] != null
        ? FiscalYearInfo.fromJson(json['fiscalYearInfo'])
        : null;
    authResult = json['authResult'] != null
        ? AuthResult.fromJson(json['authResult'])
        : null;
    ownerCompanyList = json['ownerCompanyList'] != null
        ? OwnerCompanyList.fromJson(json['ownerCompanyList'])
        : null;
    otherInfo = json['otherInfo'] != null
        ? OtherInfo.fromJson(json['otherInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userReturn != null) {
      data['userReturn'] = userReturn!.toJson();
    }
    if (departmentBranches != null) {
      data['departmentBranches'] =
          departmentBranches!.map((v) => v.toJson()).toList();
    }
    if (fiscalYearInfo != null) {
      data['fiscalYearInfo'] = fiscalYearInfo!.toJson();
    }
    if (authResult != null) {
      data['authResult'] = authResult!.toJson();
    }
    if (ownerCompanyList != null) {
      data['ownerCompanyList'] = ownerCompanyList!.toJson();
    }
    if (otherInfo != null) {
      data['otherInfo'] = otherInfo!.toJson();
    }
    return data;
  }
}

class UserReturn {
  int? intUserId;
  String? strUsername;
  String? strName;
  String? strEmail;
  String? dtFromdate;
  String? dtToDate;
  String? strAddress;
  String? strContact;
  int? designationId;
  String? strProfile;
  String? strCode;
  bool? status;
  String? extra2;
  String? extra3;
  String? designationName;
  String? sessionId;
  String? checkUser;

  UserReturn({
    this.intUserId,
    this.strUsername,
    this.strName,
    this.strEmail,
    this.dtFromdate,
    this.dtToDate,
    this.strAddress,
    this.strContact,
    this.designationId,
    this.strProfile,
    this.strCode,
    this.status,
    this.extra2,
    this.extra3,
    this.designationName,
    this.sessionId,
    this.checkUser,
  });

  UserReturn.fromJson(Map<String, dynamic> json) {
    intUserId = json['intUserId'];
    strUsername = json['strUsername'];
    strName = json['strName'];
    strEmail = json['strEmail'];
    dtFromdate = json['dtFromdate'];
    dtToDate = json['dtToDate'];
    strAddress = json['strAddress'];
    strContact = json['strContact'];
    designationId = json['designation_Id'];
    strProfile = json['strProfile'];
    strCode = json['strCode'];
    status = json['status'];
    extra2 = json['extra2'];
    extra3 = json['extra3'];
    designationName = json['designation_Name'];
    sessionId = json["sessionId"];
    checkUser = json["checkUser"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['intUserId'] = intUserId;
    data['strUsername'] = strUsername;
    data['strName'] = strName;
    data['strEmail'] = strEmail;
    data['dtFromdate'] = dtFromdate;
    data['dtToDate'] = dtToDate;
    data['strAddress'] = strAddress;
    data['strContact'] = strContact;
    data['designation_Id'] = designationId;
    data['strProfile'] = strProfile;
    data['strCode'] = strCode;
    data['status'] = status;
    data['extra2'] = extra2;
    data['extra3'] = extra3;
    data['designation_Name'] = designationName;
    data['sessionId'] = sessionId;
    data['userName'] = checkUser;
    return data;
  }
}

class DepartmentBranches {
  int? branchDepartmentId;
  String? branchDepartment;
  int? branchId;

  DepartmentBranches(
      {this.branchDepartmentId, this.branchDepartment, this.branchId});

  DepartmentBranches.fromJson(Map<String, dynamic> json) {
    branchDepartmentId = json['branchDepartment_Id'];
    branchDepartment = json['branchDepartment'];
    branchId = json['branch_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branchDepartment_Id'] = branchDepartmentId;
    data['branchDepartment'] = branchDepartment;
    data['branch_Id'] = branchId;
    return data;
  }
}

class FiscalYearInfo {
  int? financialYearId;
  String? fromDate;
  String? toDate;
  String? fiscalYear;
  String? shortDate;
  String? createdDate;
  int? userId;
  bool? isEngOrNep;
  String? nepStartDate;
  String? nepEndDate;
  String? nepFiscalYear;
  String? nepShortDate;

  FiscalYearInfo(
      {this.financialYearId,
      this.fromDate,
      this.toDate,
      this.fiscalYear,
      this.shortDate,
      this.createdDate,
      this.userId,
      this.isEngOrNep,
      this.nepStartDate,
      this.nepEndDate,
      this.nepFiscalYear,
      this.nepShortDate});

  FiscalYearInfo.fromJson(Map<String, dynamic> json) {
    financialYearId = json['financialYearId'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    fiscalYear = json['fiscalYear'];
    shortDate = json['shortDate'];
    createdDate = json['createdDate'];
    userId = json['userId'];
    isEngOrNep = json['isEngOrNep'];
    nepStartDate = json['nepStartDate'];
    nepEndDate = json['nepEndDate'];
    nepFiscalYear = json['nepFiscalYear'];
    nepShortDate = json['nepShortDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['financialYearId'] = financialYearId;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['fiscalYear'] = fiscalYear;
    data['shortDate'] = shortDate;
    data['createdDate'] = createdDate;
    data['userId'] = userId;
    data['isEngOrNep'] = isEngOrNep;
    data['nepStartDate'] = nepStartDate;
    data['nepEndDate'] = nepEndDate;
    data['nepFiscalYear'] = nepFiscalYear;
    data['nepShortDate'] = nepShortDate;
    return data;
  }
}

class AuthResult {
  bool? success;
  String? errors;

  AuthResult({this.success, this.errors});

  AuthResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['errors'] = errors;
    return data;
  }
}

class OwnerCompanyList {
  int? companyId;
  String? companyName;
  String? address;
  String? phone;
  String? mobile;
  String? emailId;
  String? country;
  String? state;
  String? tin;
  String? cst;
  int? vatOrPan;
  String? pan;
  String? databaseName;
  String? databaseId;
  int? ownerId;
  String? joinedDate;
  String? expiryDate;
  String? remarks;

  OwnerCompanyList(
      {this.companyId,
      this.companyName,
      this.address,
      this.phone,
      this.mobile,
      this.emailId,
      this.country,
      this.state,
      this.tin,
      this.cst,
      this.vatOrPan,
      this.pan,
      this.databaseName,
      this.databaseId,
      this.ownerId,
      this.joinedDate,
      this.expiryDate,
      this.remarks});

  OwnerCompanyList.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    address = json['address'];
    phone = json['phone'];
    mobile = json['mobile'];
    emailId = json['emailId'];
    country = json['country'];
    state = json['state'];
    tin = json['tin'];
    cst = json['cst'];
    vatOrPan = json['vatOrPan'];
    pan = json['pan'];
    databaseName = json['databaseName'];
    databaseId = json['databaseId'];
    ownerId = json['ownerId'];
    joinedDate = json['joinedDate'];
    expiryDate = json['expiryDate'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['address'] = address;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['emailId'] = emailId;
    data['country'] = country;
    data['state'] = state;
    data['tin'] = tin;
    data['cst'] = cst;
    data['vatOrPan'] = vatOrPan;
    data['pan'] = pan;
    data['databaseName'] = databaseName;
    data['databaseId'] = databaseId;
    data['ownerId'] = ownerId;
    data['joinedDate'] = joinedDate;
    data['expiryDate'] = expiryDate;
    data['remarks'] = remarks;
    return data;
  }
}

class OtherInfo {
  bool? isEngOrNepali;
  bool? isPrifixUse;
  bool? isSufixUse;
  bool? isFiscalUse;
  String? dbName;
  int? branchId;
  String? decimalPlace;

  OtherInfo(
      {this.isEngOrNepali,
      this.isPrifixUse,
      this.isSufixUse,
      this.isFiscalUse,
      this.dbName,
      this.branchId,
      this.decimalPlace});

  OtherInfo.fromJson(Map<String, dynamic> json) {
    isEngOrNepali = json['isEngOrNepali'];
    isPrifixUse = json['isPrifixUse'];
    isSufixUse = json['isSufixUse'];
    isFiscalUse = json['isFiscalUse'];
    dbName = json['dbName'];
    branchId = json['branchId'];
    decimalPlace = json['decimalPlace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isEngOrNepali'] = isEngOrNepali;
    data['isPrifixUse'] = isPrifixUse;
    data['isSufixUse'] = isSufixUse;
    data['isFiscalUse'] = isFiscalUse;
    data['dbName'] = dbName;
    data['branchId'] = branchId;
    data['decimalPlace'] = decimalPlace;
    return data;
  }
}
