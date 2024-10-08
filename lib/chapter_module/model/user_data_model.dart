class UserDataModel {
  UserDataModel({
    this.message,
    this.result,
    this.status,
  });

  UserDataModel.fromJson(dynamic json) {
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
  }
  String? message;
  Result? result;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['status'] = status;
    return map;
  }
}

class Result {
  Result({
    this.email,
    this.lastRead,
    this.reads,
    this.appUpdate,
  });

  Result.fromJson(dynamic json) {
    email = json['email'];
    lastRead = json['last_read'];
    clientEndpoint = json['client_endpoint'];
    fcmToken = json['fcm_token'];
    if (json['reads'] != null) {
      reads = [];
      json['reads'].forEach((v) {
        reads?.add(Reads.fromJson(v));
      });
    }
    appUpdate = json['app_update'] != null ? AppUpdate.fromJson(json['app_update']) : null;

  }
  String? email;
  String? lastRead;
  String? fcmToken;
  String? clientEndpoint;
  List<Reads>? reads;
  AppUpdate? appUpdate;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['last_read'] = lastRead;
    if (reads != null) {
      map['reads'] = reads?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Reads {
  Reads({
    this.chapter,
    this.verses,
    this.progress,
  });

  Reads.fromJson(dynamic json) {
    chapter = json['chapter'];
    verses = json['verses'] != null ? json['verses'].cast<num>() : [];

    progress = json['progress'];
  }
  num? chapter;
  List<num>? verses;
  num? progress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chapter'] = chapter;
    map['verses'] = verses;
    map['progress'] = progress;
    return map;
  }
}



class AppUpdate {
  AppUpdate({
    this.buildNo,
    this.forceUpdate,
    this.softUpdate,
    this.message,
  });

  AppUpdate.fromJson(dynamic json) {
    buildNo = json['build_no'];
    forceUpdate = json['force_update'];
    softUpdate = json['soft_update'];
    title = json['title'];
    message = json['message'];
  }
  num? buildNo;
  num? forceUpdate;
  num? softUpdate;
  String? message;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['build_no'] = buildNo;
    map['force_update'] = forceUpdate;
    map['message'] = message;
    return map;
  }
}