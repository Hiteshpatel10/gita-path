class UserActivityModel {
  UserActivityModel({
      this.message, 
      this.result, 
      this.status,});

  UserActivityModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    status = json['status'];
  }
  String? message;
  List<Result>? result;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}

class Result {
  Result({
      this.date, 
      this.day, 
      this.activity,});

  Result.fromJson(dynamic json) {
    date = json['date'];
    day = json['day'];
    if (json['activity'] != null) {
      activity = [];
      json['activity'].forEach((v) {
        activity?.add(Activity.fromJson(v));
      });
    }
  }
  String? date;
  String? day;
  List<Activity>? activity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['day'] = day;
    if (activity != null) {
      map['activity'] = activity?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Activity {
  Activity({
      this.chapterNo, 
      this.verseNo,});

  Activity.fromJson(dynamic json) {
    chapterNo = json['chapter_no'];
    verseNo = json['verse_no'];
  }
  String? chapterNo;
  String? verseNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chapter_no'] = chapterNo;
    map['verse_no'] = verseNo;
    return map;
  }

}