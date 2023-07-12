class Api {
  static const baseUrl = 'http://202.51.74.138:88';

  static const userLogin = '$baseUrl/api/LoginAPI/Login';
  static const getMenu = '$baseUrl/api/Menu/GetMenuOfAppbyId';
  static const getList = '$baseUrl/api/CommonReport/GetallList_Rep';
  static const getTable = '$baseUrl/api/CommonReport/GetFilterAnyDataPaginationReport';
  static const getModalTable = '$baseUrl/api/CommonReport/GetFilterAnyDataPaginationReport';
  static const getLoginActivities = '$baseUrl/api/ActivityLog/GetLoginActivity';
  static const getTransactionActivities = '$baseUrl/api/ActivityLog/GetEntryMasterLog';
  static const getDashBoardAmount = '$baseUrl/api/MyFunction/DashBoardAccountGroupwithsub';
  static const getNotification = '$baseUrl/api/GlobalNotification';
}
