class ApiEndpoints {
  static const baseURL = "http://vgjgfosdf9.execute-api.ap-south-1.amazonaws.com/Prod/";
  static chapter({required int chapterNo}) => "gita/chapter/$chapterNo";
  static verse({required int chapterNo, required int verseNo}) => "gita/verse/BG$chapterNo.$verseNo";
}
