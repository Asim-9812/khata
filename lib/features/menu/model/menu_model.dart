class MenuModel {
  final int intUserMenuid;
  final int userID;
  final int intMenuid;
  final String strName;
  final String strFormName;
  final String strShorCut;
  final bool isOpen;
  final int parentID;
  final bool isActive;
  final bool hasSubMenu;
  final String webUrl;
  final int isActiveApp;
  final String menuicon;
  final bool status;
  final int intOrder;
  final bool isPrivate;

  MenuModel({
    required this.intUserMenuid,
    required this.userID,
    required this.intMenuid,
    required this.strName,
    required this.strFormName,
    required this.strShorCut,
    required this.isOpen,
    required this.parentID,
    required this.isActive,
    required this.hasSubMenu,
    required this.webUrl,
    required this.isActiveApp,
    required this.menuicon,
    required this.status,
    required this.intOrder,
    required this.isPrivate,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      intUserMenuid: json['intUserMenuid'],
      userID: json['userID'],
      intMenuid: json['intMenuid'],
      strName: json['strName'],
      strFormName: json['strFormName'],
      strShorCut: json['strShorCut'],
      isOpen: json['isOpen'],
      parentID: json['parentID'],
      isActive: json['isActive'],
      hasSubMenu: json['hasSubMenu'],
      webUrl: json['webUrl'],
      isActiveApp: json['isActiveApp'],
      menuicon: json['menuicon'],
      status: json['status'],
      intOrder: json['intOrder'],
      isPrivate: json['isPrivate'],
    );
  }
}
