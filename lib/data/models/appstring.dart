import './../../domain/all.dart';

class AppString {
  final Map string;

  AppString({
    required this.string,
  });

  factory AppString.fromfire(Map data) {
    return AppString(
      string: {
        englishlangstr: data[englishlangstr],
        arabiclangstr: data[arabiclangstr],
      },
    );
  }
}
