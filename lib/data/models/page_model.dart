import './../../domain/all.dart';

class PageModel {
  final String id;
  final Map<String, String> title;
  final Map<String, String> content;

  PageModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory PageModel.fromfire(String key, Map data) {
    return PageModel(
      id: key,
      title: {
        englishlangstr: data["TitleEnglish"],
        arabiclangstr: data["TitleArabic"],
      },
      content: {
        englishlangstr: data["ContentEnglish"],
        arabiclangstr: data["ContentArabic"],
      },
    );
  }
}
