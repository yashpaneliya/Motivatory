class Quotes {
  static const quoteTable = 'ALL_QUOTES';
  static const id = 'ID';
  static const quoteText = 'QUOTE';
  static const author = 'AUTHOR';
  static const liked = 'Liked';
  static const category = 'CATEGORY';

  static void databaseLog(
      String functionName,
      String sql,
      List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateQueryResult) {
    print(functionName);
    print(sql);
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }
}
