class DashboardMenuModel {
  int? menuId;
  String? menuName;

  DashboardMenuModel({this.menuId, this.menuName});

  DashboardMenuModel.fromJson(Map<String, dynamic> json) {
    menuId = json['MenuId'];
    menuName = json['MenuName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MenuId'] = menuId;
    data['MenuName'] = menuName;
    return data;
  }

  String get image {
    String folder = "lib/assets/dashboard_menu_icon/";
    if (menuId == 1337) {
      return "${folder}approval.png";
    } else if (menuId == 1338) {
      return "${folder}leave_application.png";
    } else if (menuId == 1339) {
      return "${folder}approve_leave.png";
    } else if (menuId == 1340) {
      return "${folder}job_card.png";
    } else if (menuId == 1341) {
      return "${folder}slip.png";
    } else if (menuId == 1342) {
      return "${folder}history.png";
    } else if (menuId == 1343) {
      return "${folder}add_employee.png";
    } else if (menuId == 1344) {
      return "${folder}history.png";
    } else if (menuId == 1345) {
      return "${folder}slip.png";
    }else if (menuId == 1346) {
      return "${folder}setleave.png";
    } else {
      return "${folder}in_progress.png";
    }
  }
}
