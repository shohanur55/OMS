

import '../dashboard_menu_model.dart';

class DashboardResponseModel {
  int? employeeId;
  int? sectionId;
  String? fingerId;
  String? fullName;
  String? designation;
  String? profilePicture;
  String? companyImage;
  List<DashboardMenuModel>? menuList;

  DashboardResponseModel({this.employeeId, this.sectionId, this.fingerId, this.fullName, this.designation, this.profilePicture, this.companyImage, this.menuList});

  DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    sectionId = json['SectionId'];
    fingerId = json['FingerId'];
    fullName = json['FullName'];
    designation = json['Designation'];
    profilePicture = json['ProfilePicture'];
    companyImage = json['CompanyImage'];
    if (json['MenuList'] != null) {
      menuList = <DashboardMenuModel>[];
      json['MenuList'].forEach((v) {
        menuList!.add(DashboardMenuModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeId'] = employeeId;
    data['SectionId'] = sectionId;
    data['FingerId'] = fingerId;
    data['FullName'] = fullName;
    data['Designation'] = designation;
    data['ProfilePicture'] = profilePicture;
    data['CompanyImage'] = companyImage;
    if (menuList != null) {
      data['MenuList'] = menuList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
