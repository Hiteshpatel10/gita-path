class ChapterModel {
  ChapterModel({
    this.chapters,
  });

  ChapterModel.fromJson(dynamic json) {
    if (json['chapters'] != null) {
      chapters = [];
      json['chapters'].forEach((v) {
        chapters?.add(Chapters.fromJson(v));
      });
    }
  }
  List<Chapters>? chapters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (chapters != null) {
      map['chapters'] = chapters?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Chapters {
  Chapters({
    this.title,
    this.verses,
  });

  Chapters.fromJson(dynamic json) {
    title = json['title'];
    verses = json['verses'];
  }
  String? title;
  num? verses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['verses'] = verses;
    return map;
  }
}


final chapterData = {
  "chapters": [
    {
      "title": "Arjuna Vishada Yoga",
      "verses": 46
    },
    {
      "title": "Sankhya Yoga",
      "verses": 72
    },
    {
      "title": "Karma Yoga",
      "verses": 43
    },
    {
      "title": "Jnana Karma Sanyasa Yoga",
      "verses": 42
    },
    {
      "title": "Karma Sanyasa Yoga",
      "verses": 29
    },
    {
      "title": "Dhyana Yoga",
      "verses": 47
    },
    {
      "title": "Jnana Vijnana Yoga",
      "verses": 20
    },
    {
      "title": "Aksara Brahma Yoga",
      "verses": 29
    },
    {
      "title": "Raja Vidya Raja Guhya Yoga",
      "verses": 34
    },
    {
      "title": "Vibhuti Yoga",
      "verses": 41
    },
    {
      "title": "Visvarupa Darshana Yoga",
      "verses": 54
    },
    {
      "title": "Bhakti Yoga",
      "verses": 70
    },
    {
      "title": "Kshetra Kshetragna Vibhaga Yoga",
      "verses": 34
    },
    {
      "title": "Gunatraya Vibhaga Yoga",
      "verses": 8
    },
    {
      "title": "Purusottama Yoga",
      "verses": 51
    },
    {
      "title": "Daivasura Sampad Vibhaga Yoga",
      "verses": 6
    },
    {
      "title": "Sraddhatraya Vibhaga Yoga",
      "verses": 18
    },
    {
      "title": "Moksha Sanyasa Yoga",
      "verses": 35
    }
  ]
};