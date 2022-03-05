import './../../domain/all.dart';

class CategoryModel {
  final String id;
  final int number;
  final Map<String, String> name;
  final String? image;
  final String displaytype;
  final List<String> tags;

  CategoryModel({
    required this.id,
    required this.number,
    required this.name,
    required this.image,
    required this.displaytype,
    required this.tags,
  });

  factory CategoryModel.fromfire(String key, Map value) {
    return CategoryModel(
      id: key,
      number: value["Number"],
      name: {
        englishlangstr: value["NameEnglish"],
        arabiclangstr: value["NameArabic"],
      },
      image: value["Image"],
      displaytype: value["DisplayType"],
      tags: (value["Tags"] as List<Object?>).map((e) => e.toString()).toList(),
    );
  }
}
