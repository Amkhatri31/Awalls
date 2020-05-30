import 'package:awalls/Model/catagories_model.dart';

String apiKey="av-wZsl5CSiOaxyH23KSCeTSMa5S7ChsH-hE4gP8mTc";

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = List();
  CategoryModel categorieModel = CategoryModel();
  categorieModel.imgUrl =
      "https://images.unsplash.com/photo-1523245787856-3b2750746be9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80";
  categorieModel.categoryName = "Street Art";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  categorieModel.imgUrl =
      "https://images.unsplash.com/photo-1590222228146-fa632770d669?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80";
  categorieModel.categoryName = "Technology";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  categorieModel.imgUrl =
      "https://images.unsplash.com/photo-1590664216212-62e763768cae?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
  categorieModel.categoryName = "Nature";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  categorieModel.imgUrl =
      "https://images.unsplash.com/photo-1498036882173-b41c28a8ba34?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80";
  categorieModel.categoryName = "City";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  categorieModel.imgUrl =
      "https://images.unsplash.com/photo-1522120691812-dcdfb625f397?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80";
  categorieModel.categoryName = "Motivation";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  categorieModel.imgUrl =
      "https://images.unsplash.com/photo-1590655863550-00153f96b862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
  categorieModel.categoryName = "Animals";
  categories.add(categorieModel);
  categorieModel = CategoryModel();

  categorieModel.imgUrl =
      "https://images.unsplash.com/photo-1494976388531-d1058494cdd8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
  categorieModel.categoryName = "Cars";
  categories.add(categorieModel);

  return categories;
}

class Data {
  int total;
  int totalPages;
  List<Results> results;

  Data({this.total, this.totalPages, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String id;
  String createdAt;
  String updatedAt;
  int width;
  int height;
  String color;
  String description;
  String altDescription;
  Urls urls;

  Results(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.width,
      this.height,
      this.color,
      this.description,
      this.altDescription,
      this.urls});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['width'] = this.width;
    data['height'] = this.height;
    data['color'] = this.color;
    data['description'] = this.description;
    data['alt_description'] = this.altDescription;
    if (this.urls != null) {
      data['urls'] = this.urls.toJson();
    }
    return data;
  }
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['full'] = this.full;
    data['regular'] = this.regular;
    data['small'] = this.small;
    data['thumb'] = this.thumb;
    return data;
  }
}