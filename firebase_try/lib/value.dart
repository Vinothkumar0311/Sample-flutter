class UserList {
  String? key, name, emailid, mobileNumber, password;
  UserList({
    required this.key,
    required this.name,
    required this.emailid,
    required this.mobileNumber,
    required this.password,
  });
  factory UserList.formJson(Map<String, dynamic> json) {
    return UserList(
      key: json['key'],
      name: json['name'],
      emailid: json['emailid'],
      mobileNumber: json['mobileNumber'],
      password: json['password'],
    );
  }
}
