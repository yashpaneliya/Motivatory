import 'package:motivatory/data/likeModel.dart';
import 'localLikeSQL.dart';

Future<List<LikedQuote>> getAllLikeQuotes() async {
  final sql = '''SELECT * FROM ${Databasecreator.liketable}''';
  final data = await likedb.rawQuery(sql);
  List<LikedQuote> quotesList = List();

  for (final node in data) {
    var temp = LikedQuote.fromJson(node);
    quotesList.add(temp);
  }

  return quotesList;
}

Future<String> likeQuote(LikedQuote lq) async {
  try {
    final sql = '''INSERT INTO ${Databasecreator.liketable}
  (
    ${Databasecreator.id},
    ${Databasecreator.quoteText},
    ${Databasecreator.author},
    ${Databasecreator.category}
  )
  VALUES
  (
    ${lq.id},
    "${lq.quoteText}",
    "${lq.author}",
    "${lq.category}"
  )
  ''';

    final res = await likedb.rawInsert(sql);
    print("Thi is Res");
    print(res);

    Databasecreator.databaselog('Add quote', sql, null, res);
    return 'done';
  } catch (e) {
    return 'exception';
  }
}

Future<void> deleteLikedQuote(LikedQuote lq) async {
  final sql =
      '''DELETE FROM ${Databasecreator.liketable} WHERE ${Databasecreator.id}=${lq.id}''';
  final res = await likedb.rawDelete(sql);
  Databasecreator.databaselog('Delete quote', sql, null, res);
}

checkAleradyLikdedOrNot(id) async {
  final sql =
      '''SELECT * FROM ${Databasecreator.liketable} WHERE ${Databasecreator.id}=${id}''';
  final res = await likedb.rawQuery(sql);
  print("Checking");
  print(res);
  print(res.length);
  return res.length;
}
