class Userprofile {
  final int? id;
  final String? username; 
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;

  Userprofile({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
  });

  factory Userprofile.fromJson(Map<String, dynamic> json) {
    return Userprofile(
      id: json['id'] != null ? json['id'] as int : null,
      username: json['username'] != null ? json['username'] as String : null,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] != null ? json['mobile'] as String : null,
    );
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
