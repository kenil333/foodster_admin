import './../../domain/all.dart';

class TagModel {
  final String id;
  final Map<String, String> name;

  TagModel({
    required this.id,
    required this.name,
  });

  factory TagModel.fromfire(String key, Map data) {
    return TagModel(
      id: key,
      name: {
        englishlangstr: data[englishlangstr],
        arabiclangstr: data[arabiclangstr],
      },
    );
  }
}
