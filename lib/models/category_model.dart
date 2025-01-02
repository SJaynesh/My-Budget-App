import 'package:flutter/services.dart';

class CategoryModel {
  int id;
  String name;
  Uint8List image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromMap({required Map<String, dynamic> data}) {
    return CategoryModel(
      id: data['category_id'],
      name: data['category_name'],
      image: data['category_image'],
    );
  }
}
