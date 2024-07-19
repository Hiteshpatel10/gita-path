class ApiEndpoints {
  static const baseURL = "http://vgjgfosdf9.execute-api.ap-south-1.amazonaws.com/Prod/";
  static const s3BaseURL = "https://gita-path.s3.ap-south-1.amazonaws.com/chapter-images/";
  static chapter({required int chapterNo}) => "gita/chapter/$chapterNo";
  static verse({required int chapterNo, required int verseNo}) => "gita/verse/BG$chapterNo.$verseNo";


  static const createUser = "gita/createUser";
  static const user = "gita/user";
}
