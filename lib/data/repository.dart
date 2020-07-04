// import 'package:motivatory/data/database_creator.dart';
// import 'package:motivatory/data/quotesData.dart';



//   //function to get all quotes
//   Future<List<Quote>> getAllQuotes()async{
//     final sql='''SELECT * FROM ${Quotes.quoteTable}''';
//     final data=await db.rawQuery(sql);
//     List<Quote> quotesList=List();

//     for(final node in data){
//       var temp=Quote.fromJson(node);
//       quotesList.add(temp);
//     }

//     return quotesList;
//   }



//     return quotesList;
//   }

//   //function to get quotes of an author
//   Future<List<Quote>> getQuoteOfAuthor(String author)async{
    
//     final sql='''SELECT * FROM ${Quotes.quoteTable} 
//     WHERE ${Quotes.author}==$author
//     ''';

//     final data = await db.rawQuery(sql);
//     List<Quote> quotesList=List();

//     for(final node in data){
//       var temp=Quote.fromJson(node);
//       quotesList.add(temp);
//     }

//     return quotesList;
//   }

//   //function to get quotes of an author
//   Future<List<dynamic>> getAllCategories()async{
    
//     final sql='''SELECT category FROM ${Quotes.quoteTable}''';

//     final data = await db.rawQuery(sql);
//     List<dynamic> catList=List();

//     for(final node in data){
//       var temp=node.toString();
//       catList.add(temp);
//     }

//     return catList;
//   }

//   //update a quotes as a liked quote
//   Future<void> likeQuote(String id)async{

//     final sql=''' UPDATE ${Quotes.quoteTable}
//     SET ${Quotes.liked}=1
//     WHERE ${Quotes.id}=$id
//     ''';
//   }  
