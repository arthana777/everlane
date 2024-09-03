class UserAddress {
  int id;
  String mobile;
  String pincode;
  String locality;
  String address;
  String city;
  String state;
  String landmark;
  bool isDefault;
  bool isActive;
  bool isDeleted;


  UserAddress({
    required this.id,
    required this.mobile,
    required this.pincode,
    required this.locality,
    required this.address,
    required this.city,
    required this.state,
    required this.landmark,
    required this.isDefault,
    required this.isActive,
    required this.isDeleted,

  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id']??"",
      mobile: json['mobile']??"",
      pincode: json['pincode']??"",
      locality: json['locality']??"",
      address: json['address']??"",
      city: json['city']??'',
      state: json['state']??'',
      landmark: json['landmark']??"",
      isDefault: json['is_default']??"",
      isActive: json['is_active']??"",
      isDeleted: json['is_deleted']??"",

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobile': mobile,
      'pincode': pincode,
      'locality': locality,
      'address': address,
      'city': city,
      'state': state,
      'landmark': landmark,
      'is_default': isDefault,
      'is_active': isActive,
      'is_deleted': isDeleted,
    };
  }
}
