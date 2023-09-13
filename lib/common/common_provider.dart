import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateNotifierProvider.autoDispose<LoadingProvider, bool>((ref) => LoadingProvider(false));

class LoadingProvider extends StateNotifier<bool>{
  LoadingProvider(super.state);
  void toggle(){
    state = !state;
  }
}


final setListProvider = ChangeNotifierProvider((ref) => LedgerProvider());

class LedgerProvider extends ChangeNotifier{

  List<String> setList(String groupIndex, List<String> data, List<String> newData) {
    switch (groupIndex) {
      case 'All':
        return newData;
      default:
        return data;
    }
  }
}

final checkProvider = ChangeNotifierProvider((ref) => BoolProvider());

class BoolProvider extends ChangeNotifier{
  bool isChecked = false;

  void updateCheck(){
    isChecked = !isChecked;
    notifyListeners();
  }

}


final dashBoardTypeProvider = StateNotifierProvider((ref) => DashboardType());

class DashboardType extends StateNotifier<String> {
  DashboardType() : super('Financial'); /// Set the initial state to 'Financial'

  void changeDashboardType(String boardType) {
    state = boardType; /// Update the state with the new string
  }
}



final itemProvider = ChangeNotifierProvider.autoDispose((ref) => GroupItem());
final ledgerIProvider = ChangeNotifierProvider.autoDispose((ref) => GroupItem());
final branchIProvider = ChangeNotifierProvider.autoDispose((ref) => GroupItem());
final updateLedgerProvider = ChangeNotifierProvider.autoDispose((ref) => GroupItem());
final updateTypeProvider = ChangeNotifierProvider.autoDispose((ref) => GroupItem());

class GroupItem extends ChangeNotifier{
  String trialBalanceType = "Group";
  String item = 'All';
  String ledgerItem = 'All';
  String ledgerItem2 = 'ALL';
  String updateLedgerItem = 'All';
  String updateLedgerItem2 = 'ALL';
  String branchItem = 'All';
  String branchItem2 = 'ALL';
  String voucherTypeItem = 'All';
  String statusType = 'All';
  String particularTypeItem = 'All';
  String search = '';
  List filteredList = [];
  bool isDetailed = false;


  void updateTrialBalanceType(String text){
    trialBalanceType = text;
    notifyListeners();
  }
  void updateIsDetailed(bool isChecked){
    isDetailed = !isDetailed;
    notifyListeners();
  }

  void updateSearch(String text){
    search = text;
    notifyListeners();
  }

  void updateList(List list){
    filteredList = list;
    notifyListeners();
  }


  void updateStatusType(String text){
    statusType = text;
    notifyListeners();
  }

  void updateVoucherType(String text){
    voucherTypeItem = text;
    notifyListeners();
  }

  void updateParticularType(String text){
    particularTypeItem = text;
    notifyListeners();
  }


  void updateItem(String text){
    item = text;
    notifyListeners();
  }

  void updateLedger(String text){
    ledgerItem = text;
    notifyListeners();
  }

  void updateLedger2(String text){
    ledgerItem2 = text;
    notifyListeners();
  }

  void updateBranch(String text){
    branchItem= text;
    notifyListeners();
  }
  void updateBranch2(String text){
    branchItem2= text;
    notifyListeners();
  }

  void changeItem(String value){
    updateLedgerItem = value;
    notifyListeners();
  }

}

