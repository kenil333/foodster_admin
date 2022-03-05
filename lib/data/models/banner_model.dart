class BannerModel {
  final String id;
  final String? image;
  final String name;
  final DateTime startdate;
  final DateTime enddate;

  BannerModel({
    required this.id,
    required this.image,
    required this.name,
    required this.startdate,
    required this.enddate,
  });

  factory BannerModel.fromfire(String key, Map data) {
    return BannerModel(
      id: key,
      image: data["Image"],
      name: data["Name"],
      startdate: DateTime.parse(data["StartDate"]),
      enddate: DateTime.parse(data["EndDate"]),
    );
  }
}
