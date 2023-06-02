class UserInput {
  int? id, mobileNumber;
  String? firstName, lastName, emailid;

  UserInput(this.firstName, this.lastName, this.emailid, this.mobileNumber);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["emailid"] = emailid;
    map["mobileNumber"] = mobileNumber;
    return map;
  }

  UserInput.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastNAme'];
    emailid = map['emailid'];
    mobileNumber = map['mobilrNumber'];
  }
}
