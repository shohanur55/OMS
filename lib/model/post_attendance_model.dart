class PostAttendanceModel {
  PostAttendanceModel({
    this.deviceNo,
    this.fpId,
    this.empId,
    this.latitude,
    this.locationName = "",
    this.longitude,
    this.picBack,
    this.picFront,
  });

  factory PostAttendanceModel.fromJson(Map<String, dynamic> json) {
    return PostAttendanceModel(
      deviceNo: json["DeviceNo"],
      fpId: json["FPId"],
      empId: json["empId"],
      latitude: json["Latitude"],
      locationName: json["LocationName"],
      longitude: json["Longitude"],
      picBack: json["PicBack"],
      picFront: json["PicFront"],
    );
  }

  String? deviceNo;
  int? empId;
  String? fpId;
  String? latitude;
  String locationName;
  String? longitude;
  String? picBack;
  String? picFront;

  Map<String, dynamic> toJson() {
    return {
      "DeviceNo": deviceNo,
      "FPId": fpId,
      "empId": empId,
      "Latitude": latitude,
      "LocationName": locationName,
      "Longitude": longitude,
      "PicBack": picBack,
      "PicFront": picFront,
    };
  }

  PostAttendanceModel copyWith({
    String? deviceNo,
    String? fpId,
    int? empId,
    String? latitude,
    String? locationName,
    String? longitude,
    String? picBack,
    String? picFront,
  }) {
    return PostAttendanceModel(
      deviceNo: deviceNo ?? this.deviceNo,
      fpId: fpId ?? this.fpId,
      empId: empId ?? this.empId,
      latitude: latitude ?? this.latitude,
      locationName: locationName ?? this.locationName,
      longitude: longitude ?? this.longitude,
      // picBack: picBack ?? this.picBack,
      picBack: picBack,
      // picFront: picFront ?? this.picFront,
      picFront: picFront,
    );
  }

  String isValidate(bool? isScan) {
    if (deviceNo == null) return "No device ID";
    if (fpId == null) return "No fingerprint ID";
    if (empId == null) return "No employee ID";
    if (latitude == null) return "Please provide location";
    // if (locationName == null) return false;
    if (longitude == null) return "Please provide location";

    if (isScan == null) return "";
    if (isScan) return "";

    if (picFront == null) return "Please provide front image";
    if (picBack == null) return "Please provide back image";

    return "";
  }
}
