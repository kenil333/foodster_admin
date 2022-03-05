import './../../domain/all.dart';

class ResturantModel {
  final String id;
  final int number;
  final Map name;
  final Map type;
  final String latitude;
  final String longitude;
  final Map timming;
  final Map description;
  final Map location;
  final List<String> tags;
  final List<String> profilepic;
  final List<String> restopic;
  final String display;

  ResturantModel({
    required this.id,
    required this.number,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.timming,
    required this.description,
    required this.location,
    required this.tags,
    required this.profilepic,
    required this.restopic,
    required this.display,
  });

  factory ResturantModel.fromfire(String key, Map value) {
    return ResturantModel(
      id: key,
      number: value["Number"],
      name: {
        englishlangstr: value["NameEnglish"],
        arabiclangstr: value["NameArabic"],
      },
      type: {
        englishlangstr: value["TypeEnglish"],
        arabiclangstr: value["TypeArabic"],
      },
      latitude: value["Latitude"],
      longitude: value["Longitude"],
      timming: {
        englishlangstr: value["TimmingEnglish"],
        arabiclangstr: value["TimmingArabic"],
      },
      description: {
        englishlangstr: value["DescriptionEnglish"],
        arabiclangstr: value["DescriptionArabic"],
      },
      location: {
        englishlangstr: value["LocationEnglish"],
        arabiclangstr: value["LocationArabic"],
      },
      tags: value["Tags"] == null
          ? []
          : (value["Tags"] as List).map((e) => e.toString()).toList(),
      profilepic: value["ProfileImage"] == null
          ? []
          : (value["ProfileImage"] as List).map((e) => e.toString()).toList(),
      restopic: value["ResturantImage"] == null
          ? []
          : (value["ResturantImage"] as List).map((e) => e.toString()).toList(),
      display: value["Display"],
    );
  }
}
