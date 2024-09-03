class Editprofile {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;

  Editprofile(
      {this.id,   
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile});

  Editprofile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}