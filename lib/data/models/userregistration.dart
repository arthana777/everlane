class Userregistration {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  int? mobile;
  String? password;
  String? confirmPassword;

  Userregistration(
      {this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.password,
      this.confirmPassword});

  Userregistration.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}