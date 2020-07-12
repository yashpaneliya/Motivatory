class CategoryModel {
  var categoryTitle;

  CategoryModel(this.categoryTitle);

  CategoryModel.fromJson(Map<String, dynamic> json) {
    this.categoryTitle = json['CATEGORY'];
  }
}
