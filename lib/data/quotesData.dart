
import 'quotesModel.dart';

class Quote{
  int id;
  var quoteText;
  var author;
  // int liked;
  var category;

  Quote(this.id,this.quoteText,this.author,this.category);

  Quote.fromJson(Map<String,dynamic> json){
    this.id=json[Quotes.id];
    this.quoteText=json[Quotes.quoteText];
    this.author=json[Quotes.author];
    // this.liked=json[Quotes.liked];
    this.category=json[Quotes.category];
  }
}