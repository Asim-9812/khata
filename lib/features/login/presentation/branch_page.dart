import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/common/common_provider.dart';
import 'package:khata_app/main.dart';
import 'package:khata_app/view/main_page.dart';



final branchProvider = Provider.autoDispose((ref) => branchName);
final branchDepartmentIdProvider = Provider.autoDispose((ref) => branchDepartmentId);
final branchIdProvider = Provider.autoDispose((ref) => branchId);


String branchName = '';

int branchId = 0;
int branchDepartmentId = 0;

class BranchPage extends StatefulWidget {
  const BranchPage({Key? key, required this.branchList,}) : super(key: key);

  final List<String> branchList;

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  late String selectedItem;
  late String companyName;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.branchList.first;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    var result = sessionBox.get('userReturn');
    var res = jsonDecode(result);


    /// getting the branch id from the session box
    final List<int> branchIdList = [];
    for(var e in res["departmentBranches"]){
      branchIdList.add(e["branch_Id"]);
    }

    /// getting the branch department id from the session box
    final List<int> branchDepartmentIdList = [];
    for(var e in res["departmentBranches"]){
      branchDepartmentIdList.add(e["branchDepartment_Id"]);
    }

    return OrientationBuilder(
      builder: (context, orientation) {
      if(orientation == Orientation.portrait){
        return Scaffold(
          backgroundColor: ColorManager.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/khata-logo.png",
                    height: 180,
                    width: 180,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 2,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'User Login',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.titleBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Login to your branch',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.textBlack,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Branch:',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.textBlack,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(width: 1, color: ColorManager.textGray),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                          underline: Container(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                          items: widget.branchList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              selectedItem = value;
                            });
                            //updateBranchName(value);
                          },
                          value: selectedItem,
                          isExpanded: true,
                          iconSize: 30,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.textBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                 Consumer(
                   builder: (context, ref, child) {
                     final isLoad = ref.watch(loadingProvider);
                     return  ElevatedButton(
                       onPressed: isLoad ? null : () {

                         ref.read(loadingProvider.notifier).toggle();
                         /// putting the selected branch to the branchBox since it is required later on the code
                         branchName = selectedItem;
                         branchBox.put('selectedBranch', selectedItem);
                         /// loop through the branch list to check the selected branch department id in the list and add it to the box
                         for(int i = 0; i < widget.branchList.length; i++){
                           if(selectedItem == widget.branchList[i]){
                             branchDepartmentId = branchDepartmentIdList[i];
                             branchBox.put('selectedBranchDepId', branchDepartmentId);
                           }
                         }
                         /// loop through the branch list to check the selected branch id in the list and add it to the box
                         for(int i = 0; i < widget.branchList.length; i++){
                           if(selectedItem == widget.branchList[i]){
                             branchId = branchIdList[i];
                             branchBox.put('selectedBranchId', branchId);
                           }
                         }
                         ref.read(loadingProvider.notifier).toggle();
                         Navigator.pushAndRemoveUntil(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const MainView(),
                           ), (route) => false,);
                       },
                       style: ElevatedButton.styleFrom(
                         minimumSize: const Size(double.infinity, 55),
                         backgroundColor: ColorManager.primary,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(8),
                         ),
                       ),
                       child:isLoad ? const Center(child: CircularProgressIndicator(color: Colors.white,))  : const Text(
                         'Login',
                         style: TextStyle(
                             fontFamily: 'Ubuntu',
                             fontSize: 20,
                             fontWeight: FontWeight.w400),
                       ),
                     );
                   },
                 )
                ],
              ),
            ),
          ),
        );
      }else{
        return Scaffold(
          backgroundColor: ColorManager.background,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                          height: height * 0.9,
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Text(
                                'User Login',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.titleBlue,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                'Login to your branch',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.textBlack,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.08,
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  'Branch:',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.textBlack,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.015,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(width: 1, color: ColorManager.textGray),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton(
                                  underline: Container(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: height * 0.08,
                                  ),
                                  items: widget.branchList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      selectedItem = value;
                                    });
                                  },
                                  value: selectedItem,
                                  isExpanded: true,
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.textBlack,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.1,),
                              Consumer(
                                builder: (context, ref, child) {
                                  final isLoad = ref.watch(loadingProvider);
                                  return  ElevatedButton(
                                    onPressed: isLoad ? null : () {
                                      ref.read(loadingProvider.notifier).toggle();
                                      /// putting the selected branch to the branchBox since it is required later on the code
                                      branchName = selectedItem;
                                      branchBox.put('selectedBranch', selectedItem);
                                      /// loop through the branch list to check the selected branch department id in the list and add it to the box
                                      for(int i = 0; i < widget.branchList.length; i++){
                                        if(selectedItem == widget.branchList[i]){
                                          branchDepartmentId = branchDepartmentIdList[i];
                                          branchBox.put('selectedBranchDepId', branchDepartmentId);
                                        }
                                      }
                                      /// loop through the branch list to check the selected branch id in the list and add it to the box
                                      for(int i = 0; i < widget.branchList.length; i++){
                                        if(selectedItem == widget.branchList[i]){
                                          branchId = branchIdList[i];
                                          branchBox.put('selectedBranchId', branchId);
                                        }
                                      }
                                      ref.read(loadingProvider.notifier).toggle();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MainView(),
                                        ), (route) => false,);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(double.infinity, 50),
                                      backgroundColor: ColorManager.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child:isLoad ? const Center(child: CircularProgressIndicator(color: Colors.white,))  : const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                    ),
                    SizedBox(
                      height: height * 0.9,
                      width: width * 0.38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/khata-logo.png",
                            height: height * 0.7,
                            width: height * 0.7,
                          ),
                         // Consumer(
                         //   builder: (context, ref, child) {
                         //     final response = ref.watch(loginResponseProvider);
                         //     final companyName = response.ownerCompanyList!.companyName;
                         //     return Text(companyName!, style: const TextStyle(fontFamily: 'Ubuntu', fontSize: 26, fontWeight: FontWeight.w500),);
                         //   },
                         // ),
                          SizedBox(height: height * 0.01,),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        );
      }
      },

    );
  }



  void updateBranchName(String newBranchName) async {
    var currentBranch = branchBox.get('selectedBranch');
    currentBranch.selectedBranch = newBranchName;
    await branchBox.put('selectedBranch', currentBranch);
  }
}
