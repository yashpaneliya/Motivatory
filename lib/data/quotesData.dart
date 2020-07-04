import 'database_creator.dart';

List<Map<String, dynamic>> quotes = [
  {
    'author': 'Anonymous',
    'quote':
        'All our dreams can come true, if we have the courage to pursue them',
    'liked': false,
    'category': 'Motivation'
  },
  {
    'author': 'Yash',
    'quote': 'If you think you are bad then I am your dad',
    'liked': false,
    'category': 'Attitude'
  },
  {
    'author': 'Shakti Boss',
    'quote':
        'play store ma aapdi 500 apps hovi joyi',
    'liked': false,
    'category': 'Ambition'
  },
  {
    'author': 'TirthRaj',
    'quote':
        'Apna kam banta bhaad me jaye janta',
    'liked': false,
    'category': 'Attitude'
  },
  {
    'author': 'Rahul Python God',
    'quote':
        'Koi mujhe mera kam bata do',
    'liked': false,
    'category': 'Lost'
  },
];


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