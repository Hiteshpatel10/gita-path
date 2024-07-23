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
  });

  Result.fromJson(dynamic json) {
    email = json['email'];
    lastRead = json['last_read'];
    if (json['reads'] != null) {
      reads = [];
      json['reads'].forEach((v) {
        reads?.add(Reads.fromJson(v));
      });
    }
  }
  String? email;
  String? lastRead;
  List<Reads>? reads;

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
