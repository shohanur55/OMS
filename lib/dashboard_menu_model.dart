class DashboardMenuModel {
  int? menuId;
  String? menuName;

  DashboardMenuModel({required this.menuId, required this.menuName});

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
    }else if (menuId == 1347) {
      return "${folder}slip.png";
    }else if (menuId == 1348) {
      return "${folder}leave_application.png";
    } else if (menuId == 1349) {
      return "${folder}contact.png";
    } else if (menuId == 1350) {
      return "${folder}contact.png";
    }else if (menuId == 1351) {
      return "${folder}contact.png";
    }else if (menuId == 1352) {
      return "${folder}contact.png";
    }else if (menuId == 1353) {
      return "${folder}img.png";
    }else if (menuId == 1354) {
      return "${folder}add_employee.png";
    }else if (menuId == 1355) {
      return "${folder}contact.png";
    }else if (menuId == 1356) {
      return "${folder}contact.png";
    }
    else if (menuId == 1357) {
      return "${folder}history.png";
    } else {
      return "${folder}in_progress.png";
    }
  }
}
