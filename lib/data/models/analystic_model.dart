class AnalysticModel {
  final String id;
  final String name;
  final List<DateTime> restoview;
  final List<DateTime> dishview;
  final List<DateTime> restobookmark;
  final List<DateTime> dishbookmark;
  final List<DateTime> share;
  final List<DateTime> mapclick;

  AnalysticModel({
    required this.id,
    required this.name,
    required this.restoview,
    required this.dishview,
    required this.restobookmark,
    required this.dishbookmark,
    required this.share,
    required this.mapclick,
  });

  factory AnalysticModel.formfire(String key, Map data) {
    List<DateTime> _retoview = [];
    List<DateTime> _dishview = [];
    List<DateTime> _restobookmark = [];
    List<DateTime> _dishbookmark = [];
    List<DateTime> _share = [];
    List<DateTime> _mapclick = [];
    if (data["Analytics"] != null) {
      if (data["Analytics"]["View"] != null) {
        if (data["Analytics"]["View"]["RestoView"] != null) {
          (data["Analytics"]["View"]["RestoView"] as Map).forEach((key, value) {
            _retoview.add(DateTime.parse(value));
          });
        }
        if (data["Analytics"]["View"]["DishView"] != null) {
          (data["Analytics"]["View"]["DishView"] as Map).forEach((key, value) {
            _dishview.add(DateTime.parse(value));
          });
        }
      }
      if (data["Analytics"]["Bookmarks"] != null) {
        if (data["Analytics"]["Bookmarks"]["RestoBookmark"] != null) {
          (data["Analytics"]["Bookmarks"]["RestoBookmark"] as Map)
              .forEach((key, value) {
            _restobookmark.add(DateTime.parse(value));
          });
        }
        if (data["Analytics"]["Bookmarks"]["DishBookmark"] != null) {
          (data["Analytics"]["Bookmarks"]["DishBookmark"] as Map)
              .forEach((key, value) {
            _dishbookmark.add(DateTime.parse(value));
          });
        }
      }
      if (data["Analytics"]["Share"] != null) {
        (data["Analytics"]["Share"] as Map).forEach((key, value) {
          _share.add(DateTime.parse(value));
        });
      }
      if (data["Analytics"]["Map"] != null) {
        (data["Analytics"]["Map"] as Map).forEach((key, value) {
          _mapclick.add(DateTime.parse(value));
        });
      }
    }
    return AnalysticModel(
      id: key,
      name: data["NameEnglish"],
      restoview: _retoview,
      dishview: _dishview,
      restobookmark: _restobookmark,
      dishbookmark: _dishbookmark,
      share: _share,
      mapclick: _mapclick,
    );
  }
}
