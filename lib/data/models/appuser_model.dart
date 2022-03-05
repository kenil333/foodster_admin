class AppUserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime date;
  final int restoviews;
  final int dishviews;
  final int restobookmarks;
  final int dishbookmarks;

  AppUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.date,
    required this.phone,
    required this.restoviews,
    required this.dishviews,
    required this.restobookmarks,
    required this.dishbookmarks,
  });

  factory AppUserModel.fromfire(String key, Map data) {
    List<String> _restoview = [];
    List<String> _dishview = [];
    List<String> _restobookmark = [];
    List<String> _dishbookmark = [];
    if (data["Analytics"] != null) {
      if (data["Analytics"]["RestoView"] != null) {
        (data["Analytics"]["RestoView"] as Map).forEach((k, value) {
          _restoview.add(value);
        });
      }
      if (data["Analytics"]["DishView"] != null) {
        (data["Analytics"]["DishView"] as Map).forEach((k, value) {
          _dishview.add(value);
        });
      }
      if (data["Analytics"]["RestoBookmark"] != null) {
        (data["Analytics"]["RestoBookmark"] as Map).forEach((k, value) {
          _restobookmark.add(value);
        });
      }
      if (data["Analytics"]["DishBookmark"] != null) {
        (data["Analytics"]["DishBookmark"] as Map).forEach((k, value) {
          _dishbookmark.add(value);
        });
      }
    }
    return AppUserModel(
      id: key,
      name: data["Name"],
      email: data["Email"],
      phone: data["Phone"],
      date: DateTime.parse(data["Date"]),
      restoviews: _restoview.length,
      dishviews: _dishview.length,
      restobookmarks: _restobookmark.length,
      dishbookmarks: _dishbookmark.length,
    );
  }
}
