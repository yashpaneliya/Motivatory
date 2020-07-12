class Author {
  var name;

  Author(this.name);

  Author.fromJson(Map<String, dynamic> json) {
    this.name = json['AUTHOR'];
  }
  
}
