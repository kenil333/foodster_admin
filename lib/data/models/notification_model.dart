import './../../domain/all.dart';

class NotificationModel {
  final String id;
  final Map name;
  final Map message;
  final DateTime date;
  final int hour;
  final int minute;

  NotificationModel({
    required this.id,
    required this.name,
    required this.message,
    required this.date,
    required this.hour,
    required this.minute,
  });

  factory NotificationModel.fromfire(String key, Map data) {
    return NotificationModel(
      id: key,
      name: {
        englishlangstr: data["NameEnglish"],
        arabiclangstr: data["NameArabic"],
      },
      message: {
        englishlangstr: data["MessageEnglish"],
        arabiclangstr: data["MessageArabic"],
      },
      date: DateTime.parse(data["Date"]),
      hour: int.parse("${data["Time"][0]}${data["Time"][1]}"),
      minute: int.parse("${data["Time"][3]}${data["Time"][4]}"),
    );
  }
}
