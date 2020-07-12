import 'package:motivatory/data/localLikeSQL.dart';

class LikedQuote {
  int id;
  var quoteText;
  var author;
  var category;

  LikedQuote(this.id, this.quoteText, this.author, this.category);

  LikedQuote.fromJson(Map<String, dynamic> json) {
    this.id = json[Databasecreator.id];
    this.quoteText = json[Databasecreator.quoteText];
    this.author = json[Databasecreator.author];
    this.category = json[Databasecreator.category];
  }
}
