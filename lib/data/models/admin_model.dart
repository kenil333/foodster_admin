class AdminModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final String usertype;
  final String resturant;
  final DateTime date;

  AdminModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.usertype,
    required this.resturant,
    required this.date,
  });

  factory AdminModel.fromfire(String key, Map value) {
    return AdminModel(
      id: key,
      email: value["Email"],
      password: value["Password"],
      name: value["Name"],
      usertype: value["UserType"],
      resturant: value["Resturant"],
      date: DateTime.parse(value["Date"]),
    );
  }
}
